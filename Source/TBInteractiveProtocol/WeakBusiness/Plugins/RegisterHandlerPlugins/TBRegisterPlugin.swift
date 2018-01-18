//
//  TBPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import CoreLocation
import TBWebViewJavascriptBridge

//handlename
let kUserInfoPlugin    = "getUserInfo"
let kTitlePlugin       = "initTitle"
let kShareLinkPlugin   = "shareLink"
let kSharePicPlugin    = "sharePic"
let kOpenMapPlugin     = "openMap"
let kCallBackPlugin    = "callBack"
let kCityInfoPlugin    = "getCityInfo"
let kUploadEventPlugin = "uploadEvent"

//getUserInfo
typealias LoginRegisterCallBack       = () -> Void
//title
typealias InitTitleRegisterCallBack   = (_ title: String, _ isShowShare: Int) -> Void
//shareLink
typealias ShareLinkRegisterCallBack   = (_ title: String, _ content: String, _ link: String, _ icon: String, _ responseCallBack: WVJBResponseCallback?) -> Void
//sharePic
typealias SharePicRegisterCallBack    = (_ isSuccess: Bool, _ imageData: NSData?, _ responseCallBack: WVJBResponseCallback?) -> Void
//openMap
typealias OpenMapRegisterCallBack     = (_ locationCoordinate2D: CLLocationCoordinate2D, _ locationName: String) -> Void
//callBack
typealias CallBackRegisterCallBack    = (_ isClosePage: Int) -> Void
//uploadEvent
typealias UploadEventRegisterCallBack = (_ eventId: String, _ params: [String: Any]) -> Void

public class TBRegisterPlugin: NSObject {
    
    //getUserInfo
    func registerUserInfo(model: TBUserInfoModel, manager: TBWebViewManager, loginRegisterCallBack: LoginRegisterCallBack?) {
        let userInfo = TBUserInfoPlugin()
        userInfo.loginRegisterCallBack = loginRegisterCallBack
        userInfo.registerHandler(model: model, manager: manager)
    }
    
    //cityInfo
    func registerCityInfo(model: TBCityInfoModel, manager: TBWebViewManager) {
        let cityInfo = TBCityInfoPlugin()
        cityInfo.registerHandler(model: model, manager: manager)
    }
    
    //shareLink
    func registerShareLink(manager: TBWebViewManager, shareLinkRegisterCallBack: ShareLinkRegisterCallBack?) {
        let shareLink = TBShareLinkPlugin()
        shareLink.shareLinkRegisterCallBack = shareLinkRegisterCallBack
        shareLink.registerHandler(manager: manager)
    }
    
    //sharePic
    func registerSharePic(manager: TBWebViewManager, sharePicRegisterCallBack: SharePicRegisterCallBack?) {
        let sharePic = TBSharePicPlugin()
        sharePic.sharePicRegisterCallBack = sharePicRegisterCallBack
        sharePic.registerHandler(manager: manager)
    }
    
    //title
    func registerTitle(manager: TBWebViewManager, initTitleRegisterCallBack: InitTitleRegisterCallBack?) {
        let title = TBTitlePlugin()
        title.initTitleRegisterCallBack = initTitleRegisterCallBack
        title.registerHandler(manager: manager)
    }
    
    //openMap
    func registerOpenMap(manager: TBWebViewManager, openMapRegisterCallBack: OpenMapRegisterCallBack?) {
        let openMap = TBOpenMapPlugin()
        openMap.openMapRegisterCallBack = openMapRegisterCallBack
        openMap.registerHandler(manager: manager)
    }
    
    //callback
    func registerCallBack(manager: TBWebViewManager, callBackRegisterCallBack: CallBackRegisterCallBack?) {
        let callBack = TBCallBackPlugin()
        callBack.callBackRegisterCallBack = callBackRegisterCallBack
        callBack.registerHandler(manager: manager)
    }
    
    //uploadEvent
    func registerUploadEvent(manager: TBWebViewManager, uploadEventRegisterCallBack: UploadEventRegisterCallBack?) {
        let uploadEvent = TBUploadEventPlugin()
        uploadEvent.uploadEventRegisterCallBack = uploadEventRegisterCallBack
        uploadEvent.registerHandler(manager: manager)
    }
    
}
