//
//  TBEvaluateJSHandler.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit

typealias EvaluateJSCompletionHandler = ((Any?, Error?) -> Swift.Void)?

class TBEvaluateJSHandler: NSObject {
    var prefixKey: String?
    var containsKey: String?
    var evaluateJavaScriptObjects: [TBEvaluateJSObject] = []
}

class TBEvaluateJSObject: NSObject {
    var evaluateJavaScript: String?
    var evaluateJSCompletionHandler: EvaluateJSCompletionHandler?
}
