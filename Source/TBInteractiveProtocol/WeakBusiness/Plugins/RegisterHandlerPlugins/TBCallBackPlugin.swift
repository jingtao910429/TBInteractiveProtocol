//
//  TBCallBackPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

class TBCallBackPlugin: NSObject {
    
    var callBackRegisterCallBack: CallBackRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kCallBackPlugin
        commond.commondResponseData = { [weak self] (data) in
            guard let `self` = self else { return }
            if let isClosePage = (data as AnyObject)["isClosePage"] {
                if isClosePage != nil {
                    if isClosePage as? Int == 1 {
                        TBWebViewHelper.currentViewController()?.navigationController?.popViewController(animated: true)
                    } else {
                        if let callBackRegisterCallBack = self.callBackRegisterCallBack {
                            callBackRegisterCallBack(-1)
                        }
                    }
                } else {
                    if let callBackRegisterCallBack = self.callBackRegisterCallBack {
                        callBackRegisterCallBack(-1)
                    }
                }
            } else {
                if let callBackRegisterCallBack = self.callBackRegisterCallBack {
                    callBackRegisterCallBack(-1)
                }
            }
        }
        let callBack = TBCallBackRegisterHandler()
        callBack.callBackRegisterHandler(commond: commond)
    }
}
