//
//  TBEvaluateJSHandler.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit

public typealias EvaluateJSCompletionHandler = ((Any?, Error?) -> Swift.Void)?

public class TBEvaluateJSHandler: NSObject {
    public var prefixKey: String?
    public var containsKey: String?
    public var evaluateJavaScriptObjects: [TBEvaluateJSObject] = []
}

public class TBEvaluateJSObject: NSObject {
    public var evaluateJavaScript: String?
    public var evaluateJSCompletionHandler: EvaluateJSCompletionHandler?
}
