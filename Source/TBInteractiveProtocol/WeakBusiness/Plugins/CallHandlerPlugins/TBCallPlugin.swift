//
//  TBCallPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit

//handlename
let kShareDataPlugin    = "getShareData"
let kGoBackPlugin       = "goBack"

public class TBCallPlugin: NSObject {
    
    public func shareDataCallHandler(manager: TBWebViewManager, shareLinkRegisterCallBack: ShareLinkRegisterCallBack?, sharePicRegisterCallBack: SharePicRegisterCallBack?) {
        let shareData = TBShareDataPlugin()
        shareData.shareLinkRegisterCallBack = shareLinkRegisterCallBack
        shareData.sharePicRegisterCallBack = sharePicRegisterCallBack
        shareData.registerHandler(manager: manager)
    }
    
    public func gobackCallHandler(manager: TBWebViewManager) {
        let goback = TBGoBackPlugin()
        goback.registerHandler(manager: manager)
    }
    
}
