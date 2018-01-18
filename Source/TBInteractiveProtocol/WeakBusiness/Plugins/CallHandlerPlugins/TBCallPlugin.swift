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
    
    func shareDataCallHandler(manager: TBWebViewManager) {
        let shareData = TBShareDataPlugin()
        shareData.registerHandler(manager: manager)
    }
    
    func gobackCallHandler(manager: TBWebViewManager) {
        let goback = TBGoBackPlugin()
        goback.registerHandler(manager: manager)
    }
    
}
