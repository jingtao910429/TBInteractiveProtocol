//
//  TBCallHandler.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBCallHandler: NSObject {
    
    var bridge: WKWebViewJavascriptBridge?
    
    func callHandler(commond: TBCallCommond) {
        self.bridge = commond.bridge
        commond.bridge?.callHandler(commond.handlerName, data: commond.data, responseCallback: { [weak commond] (responseData) in
            guard let `commond` = commond else { return }
            if let callCommondResponseData = commond.callCommondResponseData {
                callCommondResponseData(responseData)
            }
        })
    }
}
