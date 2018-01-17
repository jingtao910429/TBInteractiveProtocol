//
//  TBCallCommond.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

typealias CallCommondResponseData  = (Any?) -> Void

class TBCallCommond: NSObject {
    var bridge: WKWebViewJavascriptBridge?
    var handlerName = ""
    var data: Any?
    var callCommondResponseData: CallCommondResponseData?
}
