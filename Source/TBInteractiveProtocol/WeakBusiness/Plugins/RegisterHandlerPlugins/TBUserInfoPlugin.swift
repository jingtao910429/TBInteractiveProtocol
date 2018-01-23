//
//  UserInfoPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import ObjectMapper
import TBWebViewJavascriptBridge

public class TBUserInfoPlugin: NSObject {
    
    var loginRegisterCallBack: LoginRegisterCallBack?
    
    func registerHandler(model: TBUserInfoModel, manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kUserInfoPlugin
        commond.commondResponseDataCallback = { (data, responseCallback) in
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
                    let _data = data as! [String: AnyObject]
                    if let isNeedLogin = _data["isNeedLogin"] {
                        let _isNeedLogin = isNeedLogin as! Bool
                        if _isNeedLogin {
                            if let loginRegisterCallBack = self.loginRegisterCallBack {
                                loginRegisterCallBack()
                            }
                            response("")
                        } else {
                            
                            var data: [String: Any] = [:]
                            data["userId"] = model.userId
                            data["customerId"] = model.customerId
                            
                            var result: [String: Any] = [:]
                            result["result"] = model.result
                            result["msg"] = model.msg
                            result["data"] = data
                            
                            response(TBWebViewHelper.jsonToString(result))
                        }
                    } else {
                        if let loginRegisterCallBack = self.loginRegisterCallBack {
                            loginRegisterCallBack()
                        }
                        response("")
                    }
                    
                } else {
                    
                    var data: [String: Any] = [:]
                    
                    data["userId"] = model.userId
                    data["customerId"] = model.customerId
                    data["nickname"] = model.nickname
                    data["avatarUrl"] = model.avatarUrl
                    data["mobile"] = model.mobile
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





