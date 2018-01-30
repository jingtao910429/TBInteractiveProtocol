//
//  TBGoBackPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBGoBackPlugin: NSObject {
    func registerHandler(manager: TBWebViewManager) {
        
        var cancelGoBack = true
        let commond = TBCallCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kGoBackPlugin
        commond.data = ""
        commond.callCommondResponseData = { [weak self] (responseData) in
            guard let `self` = self else { return }
            if let _responseData = responseData {
                //取消返回操作
                cancelGoBack = false
                
                let _responseDataJson = _responseData as! [String: AnyObject]
                if let result = _responseDataJson["result"], result as! Int == 0 {
                    //获取内容
                    if let _data = _responseDataJson["data"] {
                        let _jsonData = _data as! [String: AnyObject]
                        //获取类型
                        if let type = _jsonData["backAction"] {
                            if type as! Int == 0 {
                                self.goback(manager: manager)
                            } else if type as! Int == 1 {//分享图片
                                TBWebViewHelper.currentViewController()?.navigationController?.popViewController(animated: false)
                            }
                        }
                    }
                } else {
                    self.goback(manager: manager)
                }
            }
        }
        let goback = TBGoBackHandler()
        goback.gobackCallHandler(commond: commond)
        
        let time: TimeInterval = 0.1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            guard cancelGoBack else {
                return
            }
            self.goback(manager: manager)
        }
    }
    
    func goback(manager: TBWebViewManager) {
        if (manager.webView.canGoBack) {
            manager.webView.goBack()
        } else {
            TBWebViewHelper.currentViewController()?.navigationController?.popViewController(animated: false)
        }
    }
    
}
