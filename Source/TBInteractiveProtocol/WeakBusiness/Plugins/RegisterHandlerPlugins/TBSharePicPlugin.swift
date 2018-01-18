//
//  TBSharePicPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge

public class TBSharePicPlugin: NSObject {
    
    var sharePicRegisterCallBack: SharePicRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kSharePicPlugin
        commond.commondResponseDataCallback = { [weak self] (data, responseCallBack) in
            guard let `self` = self else { return }
            if let _data = data as? [String : AnyObject] {
                self.transformToSharePic(_data, responseCallBack: responseCallBack)
            }
        }
        let sharePic = TBSharePicRegisterHandler()
        sharePic.sharePicRegisterHandler(commond: commond)
    }
    
    func transformToSharePic(_ data: [String: AnyObject], responseCallBack: WVJBResponseCallback?) {
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
