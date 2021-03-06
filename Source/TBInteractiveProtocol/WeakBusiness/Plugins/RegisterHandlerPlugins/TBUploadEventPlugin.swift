//
//  TBUploadEventPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBUploadEventPlugin: TBRegisterHandlerPlugin {
    
    var uploadEventRegisterCallBack: UploadEventRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kUploadEventPlugin
        self.commond?.commondResponseData = { (data) in
            if let _data = data as? [String: AnyObject] {
                if _data["eventId"] != nil, _data["params"] != nil, let eventId = _data["eventId"] {
                    var uri = ""
                    if let tpUri = _data["pageUri"] as? String {
                        uri = tpUri
                    }
                    if let uploadEventRegisterCallBack = self.uploadEventRegisterCallBack {
                        uploadEventRegisterCallBack("\(eventId)", uri, _data["params"] as! [String : Any])
                    }
                    return
                }
            }
        }
        let uploadEvent = TBUploadEventRegisterHandler()
        uploadEvent.uploadEventRegisterHandler(commond: self.commond!)
    }
}
