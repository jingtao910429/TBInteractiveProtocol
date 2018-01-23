//
//  TBUploadEventPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBUploadEventPlugin: NSObject {
    
    var uploadEventRegisterCallBack: UploadEventRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kUploadEventPlugin
        commond.commondResponseData = { (data) in
            if let _data = data as? [String: AnyObject] {
                if _data["eventId"] != nil, _data["params"] != nil {
                    let eventId = _data["eventId"] as! String
                    if let uploadEventRegisterCallBack = self.uploadEventRegisterCallBack {
                        uploadEventRegisterCallBack(eventId, _data["params"] as! [String : Any])
                    }
                    return
                }
            }
        }
        let uploadEvent = TBUploadEventRegisterHandler()
        uploadEvent.uploadEventRegisterHandler(commond: commond)
    }
}
