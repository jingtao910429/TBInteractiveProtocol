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

public class TBOpenMapPlugin: TBRegisterHandlerPlugin {
    
    var openMapRegisterCallBack: OpenMapRegisterCallBack?
    
    func registerHandler(manager: TBWebViewManager) {
        self.commond = TBRegisterCommond()
        self.commond?.bridge = manager.bridge
        self.commond?.handlerName = kOpenMapPlugin
        self.commond?.commondResponseData = { (data) in
            if let _data = data as? [String : AnyObject] {
                var latitude: CGFloat = 0
                if let _latitude = _data["latitude"] as? CGFloat {
                    latitude = _latitude
                }
                var longitude: CGFloat = 0
                if let _longitude = _data["longitude"] as? CGFloat {
                    longitude = _longitude
                }
                var locationName = ""
                if let _locationName = _data["locationName"] as? String {
                    locationName = _locationName
                }
                if latitude != 0 && longitude != 0 {
                    let locationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
                    if let openMapRegisterCallBack = self.openMapRegisterCallBack {
                        openMapRegisterCallBack(locationCoordinate2D, locationName)
                    }
                }
            }
        }
        let openMap = TBOpenMapRegisterHandler()
        openMap.openMapRegisterHandler(commond: self.commond!)
    }
}
