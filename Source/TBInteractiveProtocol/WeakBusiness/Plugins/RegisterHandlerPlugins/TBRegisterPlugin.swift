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
let kOpenUrlPlugin     = "openUrl"

//getUserInfo
public typealias LoginRegisterCallBack       = () -> Void
//title
public typealias InitTitleRegisterCallBack   = (_ info: [String: AnyObject]?, _ title: String, _ isShowShare: Int) -> Void
//shareLink
public typealias ShareLinkRegisterCallBack   = (_ title: String, _ content: String, _ link: String, _ icon: String, _ responseCallBack: WVJBResponseCallback?) -> Void
//sharePic
public typealias SharePicRegisterCallBack    = (_ isSuccess: Bool, _ imageData: NSData?, _ responseCallBack: WVJBResponseCallback?) -> Void
//openMap
public typealias OpenMapRegisterCallBack     = (_ locationCoordinate2D: CLLocationCoordinate2D, _ locationName: String) -> Void
//callBack
public typealias CallBackRegisterCallBack    = (_ isClosePage: Int) -> Void
//uploadEvent
public typealias UploadEventRegisterCallBack = (_ eventId: String, _ params: [String: Any]) -> Void
//openUrl
public typealias OpenUrlRegisterCallBack = (_ url: String) -> Void

public class TBRegisterHandlerPlugin: NSObject {
    var commond: TBRegisterCommond?
}

public class TBRegisterPlugin: NSObject {
    
    //getUserInfo
    public func registerUserInfo(model: TBUserInfoModel, manager: TBWebViewManager, loginRegisterCallBack: LoginRegisterCallBack?) {
        let userInfo = TBUserInfoPlugin()
        userInfo.loginRegisterCallBack = loginRegisterCallBack
        userInfo.registerHandler(model: model, manager: manager)
    }
    
    //agent-getUserInfo
    public func registerAgentUserInfo(model: TBUserInfoModel, manager: TBWebViewManager, loginRegisterCallBack: LoginRegisterCallBack?) {
        let userInfo = TBAgentUserInfoPlugin()
        userInfo.loginRegisterCallBack = loginRegisterCallBack
        userInfo.registerHandler(model: model, manager: manager)
    }
    
    //cityInfo
    public func registerCityInfo(model: TBCityInfoModel, manager: TBWebViewManager) {
        let cityInfo = TBCityInfoPlugin()
        cityInfo.registerHandler(model: model, manager: manager)
    }
    
    //shareLink
    public func registerShareLink(manager: TBWebViewManager, shareLinkRegisterCallBack: ShareLinkRegisterCallBack?) {
        let shareLink = TBShareLinkPlugin()
        shareLink.shareLinkRegisterCallBack = shareLinkRegisterCallBack
        shareLink.registerHandler(manager: manager)
    }
    
    //sharePic
    public func registerSharePic(manager: TBWebViewManager, sharePicRegisterCallBack: SharePicRegisterCallBack?) {
        let sharePic = TBSharePicPlugin()
        sharePic.sharePicRegisterCallBack = sharePicRegisterCallBack
        sharePic.registerHandler(manager: manager)
    }
    
    //title
    public func registerTitle(manager: TBWebViewManager, initTitleRegisterCallBack: InitTitleRegisterCallBack?) {
        let title = TBTitlePlugin()
        title.initTitleRegisterCallBack = initTitleRegisterCallBack
        title.registerHandler(manager: manager)
    }
    
    //openMap
    public func registerOpenMap(manager: TBWebViewManager, openMapRegisterCallBack: OpenMapRegisterCallBack?) {
        let openMap = TBOpenMapPlugin()
        openMap.openMapRegisterCallBack = openMapRegisterCallBack
        openMap.registerHandler(manager: manager)
    }
    
    //callback
    public func registerCallBack(manager: TBWebViewManager, callBackRegisterCallBack: CallBackRegisterCallBack?) {
        let callBack = TBCallBackPlugin()
        callBack.callBackRegisterCallBack = callBackRegisterCallBack
        callBack.registerHandler(manager: manager)
    }
    
    //uploadEvent
    public func registerUploadEvent(manager: TBWebViewManager, uploadEventRegisterCallBack: UploadEventRegisterCallBack?) {
        let uploadEvent = TBUploadEventPlugin()
        uploadEvent.uploadEventRegisterCallBack = uploadEventRegisterCallBack
        uploadEvent.registerHandler(manager: manager)
    }
    
    //openUrl
    public func registerOpenUrl(manager: TBWebViewManager, openUrlRegisterCallBack: OpenUrlRegisterCallBack?) {
        let openUrl = TBOpenUrlPlugin()
        openUrl.openUrlRegisterCallBack = openUrlRegisterCallBack
        openUrl.registerHandler(manager: manager)
    }
    
}
