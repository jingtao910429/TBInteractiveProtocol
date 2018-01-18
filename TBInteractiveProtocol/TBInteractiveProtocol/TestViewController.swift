//
//  TestViewController.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit
import TBWebViewJavascriptBridge
import TBInteractiveProtocol

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TBWebViewJavascriptBridgeVersionNumber
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
