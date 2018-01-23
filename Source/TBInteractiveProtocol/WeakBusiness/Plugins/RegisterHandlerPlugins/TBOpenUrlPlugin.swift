//
//  TBOpenUrlPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBOpenUrlPlugin: NSObject {
    
    var openUrlRegisterCallBack: OpenUrlRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kOpenUrlPlugin
        commond.commondResponseData = { (data) in
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
        openUrl.openUrlRegisterHandler(commond: commond)
    }
    
}
