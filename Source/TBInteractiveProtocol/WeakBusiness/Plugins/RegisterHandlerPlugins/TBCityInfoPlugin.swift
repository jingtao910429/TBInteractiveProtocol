//
//  TBCityInfoPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBCityInfoPlugin: TBRegisterHandlerPlugin {
    func registerHandler(model: TBCityInfoModel, manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kCityInfoPlugin
        self.commond?.commondResponseDataCallback = { (data, responseCallBack) in
            if let _responseCallback = responseCallBack {
                let response = _responseCallback as WVJBResponseCallback
                
                var result: [String: Any] = [:]
                result["result"] = model.result
                result["msg"] = model.msg
                
                var data: [String: Any] = [:]
                data["cityId"] = model.cityId
                result["data"] = data
                
                let resultStr = TBWebViewHelper.jsonToString(result)
                response(resultStr)
            }
        }
        let cityInfo = TBCityInfoRegisterHandler()
        cityInfo.cityInfoRegisterHandler(commond: self.commond!)
    }
}
