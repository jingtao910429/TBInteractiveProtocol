//
//  TBRegisterCommond.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

typealias CommondResponseDataCallback  = (Any?, WVJBResponseCallback?) -> Void
typealias CommondResponseData  = (Any?) -> Void

class TBRegisterCommond: NSObject {
    var bridge: WKWebViewJavascriptBridge?
    var handlerName = ""
    var commondResponseDataCallback: CommondResponseDataCallback?
    var commondResponseData: CommondResponseData?
    
    deinit {
        bridge = nil
        commondResponseDataCallback = nil
        commondResponseData = nil
    }
}
