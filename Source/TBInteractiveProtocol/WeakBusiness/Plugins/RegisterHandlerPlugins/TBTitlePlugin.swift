//
//  TBTitlePlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBTitlePlugin: NSObject {
    
    var initTitleRegisterCallBack: InitTitleRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kTitlePlugin
        commond.commondResponseData = { [weak self] (data) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if let _data = (data as AnyObject)["data"] {
                    let info = _data as! [String: AnyObject]
                    //标题
                    var isShowShareResult = 0
                    var titleResult = ""
                    if let navTitle = info["title"] as? String {
                        titleResult = navTitle
                    }
                    //分享按钮
                    if let showShare = info["isShowShare"] {
                        if let isShowShare = showShare as? Int {
                            isShowShareResult = isShowShare
                        }
                    }
                    if let initTitleRegisterCallBack = self.initTitleRegisterCallBack {
                        initTitleRegisterCallBack(titleResult, isShowShareResult)
                    }
                }
            }
        }
        let title = TBTitleRegisterHandler()
        title.titleRegisterHandler(commond: commond)
    }
    
}