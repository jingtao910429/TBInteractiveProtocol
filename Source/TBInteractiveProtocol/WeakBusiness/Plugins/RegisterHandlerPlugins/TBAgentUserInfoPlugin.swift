//
//  TBAgentUserInfoPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import ObjectMapper
import TBWebViewJavascriptBridge

class TBAgentUserInfoPlugin: NSObject {
    
    var loginRegisterCallBack: LoginRegisterCallBack?
    
    func registerHandler(model: TBUserInfoModel, manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kUserInfoPlugin
        commond.commondResponseDataCallback = { [weak self] (data, responseCallback) in
            guard let `self` = self else { return }
            if let _responseCallback = responseCallback {
                let response = _responseCallback as WVJBResponseCallback
                
                if model.userId == "" {
                    guard data != nil else {
                        if let loginRegisterCallBack = self.loginRegisterCallBack {
                            loginRegisterCallBack()
                        }
                        response("")
                        return
                    }
                } else {
                    
                    var data: [String: Any] = [:]
                    
                    data["userId"] = model.userId
                    data["nickname"] = model.nickname
                    data["avatarUrl"] = model.avatarUrl
                    data["accessToken"] = model.accessToken
                    
                    var result: [String: Any] = [:]
                    result["result"] = model.result
                    result["msg"] = model.msg
                    result["data"] = data
                    
                    response(TBWebViewHelper.jsonToString(result))
                }
            }
        }
        let userInfo = TBUserInfoRegisterHandler()
        userInfo.userInfoRegisterHandler(commond: commond)
    }
}
