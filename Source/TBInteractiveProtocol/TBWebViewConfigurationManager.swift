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
class TBWebViewConfigurationManager: NSObject {
    
    func configuration(selectionGranularity: WKSelectionGranularity? = .dynamic, allowsInlineMediaPlayback: Bool = false, requiresUserActionForMediaPlayback: Bool = true, mediaPlaybackRequiresUserAction: Bool = true) -> WKWebViewConfiguration! {
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
}
