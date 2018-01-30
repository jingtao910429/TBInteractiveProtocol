//
//  TBOpenUrlPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBOpenUrlPlugin: TBRegisterHandlerPlugin {
    
    var openUrlRegisterCallBack: OpenUrlRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kOpenUrlPlugin
        self.commond?.commondResponseData = { (data) in
            if let _data = data {
                if let result = _data as? [String : AnyObject] {
                    if let url = result["url"] as? String {
                        let tUrl = NSString(string: url)
                        if tUrl.length > 0 {
                            if let openUrlRegisterCallBack = self.openUrlRegisterCallBack {
                                openUrlRegisterCallBack(url)
                            }
                        }
                    }
                }
            }
        }
        let openUrl = TBOpenUrlRegisterHandler()
        openUrl.openUrlRegisterHandler(commond: self.commond!)
    }
    
}
