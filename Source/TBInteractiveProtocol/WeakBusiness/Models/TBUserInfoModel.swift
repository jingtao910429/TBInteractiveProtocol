//
//  TBUserInfoModel.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import ObjectMapper

public struct TBUserInfoModel: Mappable {
    public var userId = "0"
    public var msg = ""
    public var result = 0
    public var customerId = ""
    public var nickname = ""
    public var avatarUrl = ""
    public var mobile = ""
    public var accessToken = ""
    public var data: Any?
    
    public init() {
    }
    
    public init?(map: Map) {
    }
    
    var nonnilMapProperties: [String] {
        return []
    }
    
    mutating public func mapping(map: Map) {
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

