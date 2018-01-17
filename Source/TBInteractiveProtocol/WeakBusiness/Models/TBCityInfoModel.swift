//
//  TBCityInfoModel.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import ObjectMapper

struct TBCityInfoModel: Mappable {
    var msg = ""
    var result = 0
    var cityId = ""
    var data: Any?
    
    init?(map: Map) {
    }
    
    var nonnilMapProperties: [String] {
        return []
    }
    
    mutating func mapping(map: Map) {
        msg <- map["msg"]
        result <- map["result"]
        cityId <- map["cityId"]
        data <- map["data"]
    }
}
