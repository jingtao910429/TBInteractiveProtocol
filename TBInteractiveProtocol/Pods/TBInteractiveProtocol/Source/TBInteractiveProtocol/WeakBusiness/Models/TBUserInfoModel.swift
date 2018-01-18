//
//  TBUserInfoModel.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import ObjectMapper

struct TBUserInfoModel: Mappable {
    var userId = "0"
    var msg = ""
    var result = 0
    var customerId = ""
    var nickname = ""
    var avatarUrl = ""
    var mobile = ""
    var accessToken = ""
    var data: Any?
    
    init?(map: Map) {
    }
    
    var nonnilMapProperties: [String] {
        return []
    }
    
    mutating func mapping(map: Map) {
        userId <- map["userId"]
        msg <- map["msg"]
        result <- map["result"]
        customerId <- map["customerId"]
        nickname <- map["nickname"]
        avatarUrl <- map["avatarUrl"]
        mobile <- map["mobile"]
        accessToken <- map["accessToken"]
        data <- map["data"]
    }
}

