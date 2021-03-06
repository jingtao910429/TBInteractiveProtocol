//
//  TBCallBackPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBCallBackPlugin: TBRegisterHandlerPlugin {
    
    var callBackRegisterCallBack: CallBackRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kCallBackPlugin
        self.commond?.commondResponseData = { [weak self] (data) in
            guard let `self` = self else { return }
            if let isClosePage = (data as AnyObject)["isClosePage"] {
                if isClosePage != nil {
                    if isClosePage as? Int == 1 {
                        TBWebViewHelper.currentViewController()?.navigationController?.popViewController(animated: true)
                    } else {
                        self.goback(manager: manager)
                        if let callBackRegisterCallBack = self.callBackRegisterCallBack {
                            callBackRegisterCallBack(-1)
                        }
                    }
                } else {
                    self.goback(manager: manager)
                    if let callBackRegisterCallBack = self.callBackRegisterCallBack {
                        callBackRegisterCallBack(-1)
                    }
                }
            } else {
                self.goback(manager: manager)
                if let callBackRegisterCallBack = self.callBackRegisterCallBack {
                    callBackRegisterCallBack(-1)
                }
            }
        }
        let callBack = TBCallBackRegisterHandler()
        callBack.callBackRegisterHandler(commond: self.commond!)
    }
    
    func goback(manager: TBWebViewManager) {
        if (manager.webView.canGoBack) {
            manager.webView.goBack()
        } else {
            TBWebViewHelper.currentViewController()?.navigationController?.popViewController(animated: false)
        }
    }
}
