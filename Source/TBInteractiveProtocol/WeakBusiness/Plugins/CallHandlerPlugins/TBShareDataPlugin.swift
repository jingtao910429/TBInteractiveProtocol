//
//  TBShareDataPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBShareDataPlugin: TBCallHandlerPlugin {
    
    public var shareLinkRegisterCallBack: ShareLinkRegisterCallBack?
    public var sharePicRegisterCallBack: SharePicRegisterCallBack?
    
    public func registerHandler(manager: TBWebViewManager) {
        
        let shareLinkPlugin = TBShareLinkPlugin()
        shareLinkPlugin.shareLinkRegisterCallBack = shareLinkRegisterCallBack
        
        let sharePicPlugin = TBSharePicPlugin()
        sharePicPlugin.sharePicRegisterCallBack = sharePicRegisterCallBack
        
        self.commond = TBCallCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kShareDataPlugin
        self.commond?.data = ""
        self.commond?.callCommondResponseData = { (responseData) in
            if let _responseData = responseData {
                let _responseDataJson = _responseData as! [String: AnyObject]
                if let result = _responseDataJson["result"], result as! Int == 0 {
                    //获取内容
                    if let _data = _responseDataJson["data"] {
                        let _jsonData = _data as! [String: AnyObject]
                        //获取类型
                        if let type = _jsonData["type"] {
                            //type == 1 分享链接 type == 2 分享图片
                            if type as! Int == 1 {
                                shareLinkPlugin.transformToShare(_jsonData, responseCallBack: nil)
                            } else if type as! Int == 2 {
                                sharePicPlugin.transformToSharePic(_jsonData, responseCallBack: nil)
                            }
                        }
                    }
                }
            }
        }
        let shareData = TBShareDataCallHandler()
        shareData.shareDataCallHandler(commond: self.commond!)
    }
}
