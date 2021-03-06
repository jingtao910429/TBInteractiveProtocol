//
//  TBShareLinkPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBShareLinkPlugin: TBRegisterHandlerPlugin {
    
    var shareLinkRegisterCallBack: ShareLinkRegisterCallBack?
    
    public func registerHandler(manager: TBWebViewManager) {
        
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kShareLinkPlugin
        self.commond?.commondResponseDataCallback = { [weak self] (data, responseCallBack) in
            guard let `self` = self else { return }
            if let _data = data {
                let info = _data as! [String: AnyObject]
                self.transformToShare(info, responseCallBack: responseCallBack)
            }
        }
        
        let shareLink = TBShareLinkRegisterHandler()
        shareLink.shareLinkRegisterHandler(commond: self.commond!)
    }
    
    public func transformToShare(_ info: [String: AnyObject], responseCallBack: WVJBResponseCallback?) {
        
        var title = ""
        if let _title = info["title"] {
            title = _title as! String
        }
        var content = ""
        if let _content = info["content"] {
            content = _content as! String
        }
        var link = ""
        if let _link = info["link"] {
            link = _link as! String
        }
        var icon = ""
        if let _icon = info["icon"] {
            icon = _icon as! String
        }
        
        if let shareLinkRegisterCallBack = self.shareLinkRegisterCallBack {
            shareLinkRegisterCallBack(title, content, link, icon, responseCallBack)
        }
    }
}
