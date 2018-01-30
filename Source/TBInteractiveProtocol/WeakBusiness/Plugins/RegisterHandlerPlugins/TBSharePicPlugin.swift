//
//  TBSharePicPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBSharePicPlugin: TBRegisterHandlerPlugin {
    
    public var sharePicRegisterCallBack: SharePicRegisterCallBack?
    
    public func registerHandler(manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kSharePicPlugin
        self.commond?.commondResponseDataCallback = { [weak self] (data, responseCallBack) in
            guard let `self` = self else { return }
            if let _data = data as? [String : AnyObject] {
                self.transformToSharePic(_data, responseCallBack: responseCallBack)
            }
        }
        let sharePic = TBSharePicRegisterHandler()
        sharePic.sharePicRegisterHandler(commond: self.commond!)
    }
    
    public func transformToSharePic(_ data: [String: AnyObject], responseCallBack: WVJBResponseCallback?) {
        let imageStr = data["picData"] as! String
        let imageData = NSData(base64Encoded: imageStr, options: NSData.Base64DecodingOptions())
        if imageData != nil {
            if let sharePicRegisterCallBack = self.sharePicRegisterCallBack {
                sharePicRegisterCallBack(true, imageData, responseCallBack)
            }
        } else {
            if let sharePicRegisterCallBack = self.sharePicRegisterCallBack {
                sharePicRegisterCallBack(false, nil, responseCallBack)
            }
        }
    }
}
