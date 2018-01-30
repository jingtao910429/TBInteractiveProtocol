//
//  TBTitlePlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBTitlePlugin: TBRegisterHandlerPlugin {
    
    var initTitleRegisterCallBack: InitTitleRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kTitlePlugin
        self.commond?.commondResponseData = { (data) in
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
                        initTitleRegisterCallBack(info, titleResult, isShowShareResult)
                    }
                }
            }
        }
        let title = TBTitleRegisterHandler()
        title.titleRegisterHandler(commond: self.commond!)
    }
    
}
