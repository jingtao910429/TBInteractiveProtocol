//
//  TBWebViewConfigurationManager.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import WebKit

//WebView配置
public class TBWebViewConfigurationManager: NSObject {
    
    func configuration(selectionGranularity: WKSelectionGranularity? = .character, allowsInlineMediaPlayback: Bool = true, requiresUserActionForMediaPlayback: Bool = false, mediaPlaybackRequiresUserAction: Bool = false) -> WKWebViewConfiguration! {
        let configuration = WKWebViewConfiguration()
        if let selectionGranularity = selectionGranularity {
            configuration.selectionGranularity = selectionGranularity
        }
        configuration.allowsInlineMediaPlayback = allowsInlineMediaPlayback
        //自动播放
        if #available(iOS 9.0, *) {
            configuration.requiresUserActionForMediaPlayback = requiresUserActionForMediaPlayback
        } else {
            configuration.mediaPlaybackRequiresUserAction = mediaPlaybackRequiresUserAction
        }
        return configuration
    }
    
    func decidePolicyDecisionHandler(url: String, prefixs: [(String, Bool)], callback: (String) -> Void, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        for prefix in prefixs {
            if url.hasPrefix(prefix.0), prefix.1 {
                callback(prefix.0)
            } else {
                decisionHandler(.cancel)
            }
        }
    }
}
