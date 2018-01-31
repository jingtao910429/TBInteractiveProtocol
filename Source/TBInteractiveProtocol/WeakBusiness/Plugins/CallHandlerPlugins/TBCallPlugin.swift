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

public class TBCallHandlerPlugin: NSObject {
    var commond: TBCallCommond?
}

public class TBCallPlugin: NSObject {
    
    var shareData: TBShareDataPlugin?
    var goback: TBGoBackPlugin?
    
    public func shareDataCallHandler(manager: TBWebViewManager, shareLinkRegisterCallBack: ShareLinkRegisterCallBack?, sharePicRegisterCallBack: SharePicRegisterCallBack?) {
        shareData = TBShareDataPlugin()
        shareData?.shareLinkRegisterCallBack = shareLinkRegisterCallBack
        shareData?.sharePicRegisterCallBack = sharePicRegisterCallBack
        shareData?.registerHandler(manager: manager)
    }
    
    public func gobackCallHandler(manager: TBWebViewManager) {
        goback = TBGoBackPlugin()
        goback?.registerHandler(manager: manager)
    }
}
