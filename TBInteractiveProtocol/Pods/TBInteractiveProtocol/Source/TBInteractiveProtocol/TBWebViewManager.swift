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

protocol TBWebViewNavigationDelegate {
    
    //WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
}

protocol TBWebViewURLDelegate {
    func webViewUrlDefault() -> String
}

open class TBWebViewManager: NSObject {
    
    fileprivate(set) var webView: WKWebView!
    fileprivate(set) var bridge: WKWebViewJavascriptBridge!
    fileprivate var progressView: TBWebProgressView!
    
    var delegate: TBWebViewNavigationDelegate?
    var urlDelegate: TBWebViewURLDelegate?
    
    fileprivate var originUrl: URL!
    fileprivate var url: String? {
        didSet {
            self.originUrl = TBWebViewHelper.handleUrl(url: url)
            if let _ = self.originUrl {
            } else {
                self.originUrl = URL(string: (self.urlDelegate?.webViewUrlDefault())!)!
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    func loadView(frame: CGRect, configuration: WKWebViewConfiguration?) {
        if let configuration = configuration {
            self.webView = WKWebView(frame: frame, configuration: configuration)
        } else {
            self.webView = WKWebView(frame: frame)
        }
        setWebViewAttribute()
    }
    
    func load(_ request: String?) -> WKNavigation? {
        if self.webView == nil {
            print("请先加载WebView")
            return nil
        }
        self.url = request
        return self.webView.load(URLRequest(url: self.originUrl))
    }
    
    //执行JS
    func evaluateJavaScripts(datas: [TBEvaluateJSHandler]) {
        if datas.count == 0 {
            return
        }
        for handler in datas {
            evaluateJavaScript(handler: handler)
        }
    }
    
    //执行单个JS
    func evaluateJavaScript(handler: TBEvaluateJSHandler) {
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
    
    required public init?(coder: NSCoder) {
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
        self.delegate?.webView(webView, didCommit: navigation)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.delegate?.webView(webView, didFinish: navigation)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.delegate?.webView(webView, didFail: navigation, withError: error)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.delegate?.webView(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
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
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        if let current = TBWebViewHelper.currentViewController() {
            current.present(alert, animated: true, completion: nil)
        }
    }
    
}


