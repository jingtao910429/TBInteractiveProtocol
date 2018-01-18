//
//  TBOpenMapPlugin.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import CoreLocation
import TBWebViewJavascriptBridge

public class TBOpenMapPlugin: NSObject {
    
    var openMapRegisterCallBack: OpenMapRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        let commond = TBRegisterCommond()
        commond.bridge = manager.bridge
        commond.handlerName = kOpenMapPlugin
        commond.commondResponseData = { [weak self] (data) in
            guard let `self` = self else { return }
            if let _data = data as? [String : AnyObject] {
                var latitude: CGFloat = 0
                if let _latitude = _data["latitude"] {
                    latitude = _latitude as! CGFloat
                }
                var longitude: CGFloat = 0
                if let _longitude = _data["longitude"] {
                    longitude = _longitude as! CGFloat
                }
                var locationName = ""
                if let _locationName = _data["locationName"] {
                    locationName = _locationName as! String
                }
                let locationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
                if let openMapRegisterCallBack = self.openMapRegisterCallBack {
                    openMapRegisterCallBack(locationCoordinate2D, locationName)
                }
            }
        }
        let openMap = TBOpenMapRegisterHandler()
        openMap.openMapRegisterHandler(commond: commond)
    }
}
