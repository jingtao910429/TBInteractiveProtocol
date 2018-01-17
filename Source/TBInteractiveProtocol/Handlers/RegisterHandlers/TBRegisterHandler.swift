//
//  TBRegisterHandler.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBRegisterHandler: JSHandler {
    
    func registerHandler(commond: TBRegisterCommond) {
        self.bridge = commond.bridge
        if bridge != nil {
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    commond.bridge?.registerHandler(commond.handlerName) { (data, responseCallback) in
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