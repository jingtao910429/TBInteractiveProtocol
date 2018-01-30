//
//  TBRegisterHandler.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBRegisterHandler: NSObject {
    
    var bridge: WKWebViewJavascriptBridge?
    
    func registerHandler(commond: TBRegisterCommond) {
        self.bridge = commond.bridge
        if bridge != nil {
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    commond.bridge?.registerHandler(commond.handlerName) { [weak commond] (data, responseCallback) in
                        guard let `commond` = commond else { return }
                        if let commondResponseData = commond.commondResponseData {
                            if let _data = data {
                                commondResponseData(_data)
                            } else {
                                print("\(commond.handlerName)下 responseData 为空")
                            }
                        }
                        if let commondResponseDataCallback = commond.commondResponseDataCallback {
                            if let _responseCallback = responseCallback {
                                commondResponseDataCallback(data, _responseCallback)
                            } else {
                                print("\(commond.handlerName)下 responseCallback 为空")
                            }
                        }
                    }
                }
            }
        } else {
            assert(true, "Handler不为空!")
        }
    }
    
}
