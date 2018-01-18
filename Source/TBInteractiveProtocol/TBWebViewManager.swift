//
//  TBWebViewModule.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import WebKit
import TBWebViewJavascriptBridge

public protocol TBWebViewNavigationDelegate {
    
    //WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
}

public protocol TBWebViewDelegate {
    func webViewUrlDefault() -> String
    func fetchDecidePolicyPrefixs() -> [(String, Bool)]
    func decidePolicyCallBack(url: String, prefix: String)
}

public class TBWebViewManager: NSObject {
    
    fileprivate(set) var webView: WKWebView!
    fileprivate(set) var bridge: WKWebViewJavascriptBridge!
    
    var navDelegate: TBWebViewNavigationDelegate?
    var delegate: TBWebViewDelegate?
    
    fileprivate var originUrl: URL!
    fileprivate var url: String? {
        didSet {
            self.originUrl = TBWebViewHelper.handleUrl(url: url)
            if let _ = self.originUrl {
            } else {
                self.originUrl = URL(string: (self.delegate?.webViewUrlDefault())!)!
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    public func loadWebView(frame: CGRect) {
        self.webView = WKWebView(frame: frame, configuration: TBWebViewConfigurationManager().configuration())
        setWebViewAttribute()
    }
    
    public func load(_ url: String?) -> WKNavigation? {
        if self.webView == nil {
            print("请先加载WebView")
            return nil
        }
        if url == nil || url == "" {
            print("URL为空！")
            return nil
        }
        self.url = url
        return self.webView.load(URLRequest(url: self.originUrl))
    }
    
    //执行JS
    public func evaluateJavaScripts(datas: [TBEvaluateJSHandler]) {
        if datas.count == 0 {
            return
        }
        for handler in datas {
            evaluateJavaScript(handler: handler)
        }
    }
    
    //执行单个JS
    public func evaluateJavaScript(handler: TBEvaluateJSHandler) {
        var isExecute = false
        if let url = self.webView.url?.absoluteString {
            if let prefixKey = handler.prefixKey, url.hasPrefix(prefixKey) {
                isExecute = true
            } else if let containsKey = handler.containsKey, url.contains(containsKey) {
                isExecute = true
            } else {
                if handler.prefixKey == nil && handler.containsKey == nil {
                    isExecute = true
                }
            }
        }
        if isExecute {
            for object in handler.evaluateJavaScriptObjects {
                if let evaluateJavaScript = object.evaluateJavaScript {
                    self.webView.evaluateJavaScript(evaluateJavaScript, completionHandler: object.evaluateJSCompletionHandler ?? nil)
                }
            }
        }
    }
    
    fileprivate func setWebViewAttribute() {
        if #available(iOS 11.0, *) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        setJsBridge()
    }
    
    fileprivate func setJsBridge() {
        WKWebViewJavascriptBridge.enableLogging()
        self.bridge = WKWebViewJavascriptBridge(for: self.webView)
        self.bridge.setWebViewDelegate(self)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if #available(iOS 9.0, *) {
            if webView != nil {
                if webView.navigationDelegate != nil {
                    webView.navigationDelegate = nil
                }
                if webView.uiDelegate != nil {
                    webView.uiDelegate = nil
                }
                webView = nil
            }
        }
    }
}

extension TBWebViewManager: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.navDelegate?.webView(webView, didCommit: navigation)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navDelegate?.webView(webView, didFinish: navigation)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.navDelegate?.webView(webView, didFail: navigation, withError: error)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.navDelegate?.webView(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
        
        if let urlString = navigationAction.request.url?.absoluteString {
            let prefixs = self.delegate?.fetchDecidePolicyPrefixs()
            if let prefixs = prefixs, prefixs.count != 0 {
                TBWebViewConfigurationManager().decidePolicyDecisionHandler(url: urlString, prefixs: prefixs, callback: { (prefix) in
                    self.delegate?.decidePolicyCallBack(url: urlString, prefix: prefix)
                }, decisionHandler: decisionHandler)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        }
    }
    
}

extension TBWebViewManager: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
}

extension TBWebViewManager: WKUIDelegate {
    
    //Alert弹框
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        if let current = TBWebViewHelper.currentViewController() {
            current.present(alert, animated: true, completion: nil)
        }
    }
    
    //confirm弹框
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (_) in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (_) in
            completionHandler(false)
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        if let current = TBWebViewHelper.currentViewController() {
            current.present(alert, animated: true, completion: nil)
        }
    }
    
    //TextInput弹框
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (_) in}
        let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (_) in
            completionHandler(alert.textFields?.last?.text)
        }
        alert.addAction(action)
        if let current = TBWebViewHelper.currentViewController() {
            current.present(alert, animated: true, completion: nil)
        }
    }
    
}


