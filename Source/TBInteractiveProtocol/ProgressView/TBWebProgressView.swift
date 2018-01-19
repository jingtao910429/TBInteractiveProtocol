//
//  TBWebProgressView.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import Foundation
import NJKWebViewProgress

public class TBWebProgressView: NSObject {
    
    public var progressView: NJKWebViewProgressView!
    public var progressProxy: NJKWebViewProgress!
    
    fileprivate func createProgressView(webviewY: CGFloat, width: CGFloat) -> NJKWebViewProgressView {
        let progressBarHeight: CGFloat = 3
        let progressY = webviewY - progressBarHeight < 0 ? 0 : webviewY - progressBarHeight
        let barFrame = CGRect(x: 0, y: progressY, width: width, height: progressBarHeight)
        let progressView = NJKWebViewProgressView(frame: barFrame)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        return progressView
    }
    
    fileprivate func createProgressProxy() -> NJKWebViewProgress {
        let progressProxy = NJKWebViewProgress()
        progressProxy.progressDelegate = self
        progressProxy.webViewProxyDelegate = self
        return progressProxy
    }
    
    public func loadProgressView(container: UIView?, webviewY: CGFloat, width: CGFloat) {
        self.progressView = self.createProgressView(webviewY: webviewY, width: width)
        self.progressView.progress = 0.05
        container?.addSubview(self.progressView)
        self.progressProxy = self.createProgressProxy()
    }
}

extension TBWebProgressView: UIWebViewDelegate {
    
}

extension TBWebProgressView: NJKWebViewProgressDelegate {
    public func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        self.progressView.progress = progress
    }
}
