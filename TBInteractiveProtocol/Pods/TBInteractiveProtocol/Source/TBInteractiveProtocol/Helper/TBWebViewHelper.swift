//
//  TBWebViewCategory.swift
//  TBInteractiveProtocol
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 LiYou. All rights reserved.
//

import UIKit

class TBWebViewHelper: NSObject {
    
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    class func handleUrl(url: String?) -> URL? {
        if let url = url {
            let cfUrl = CFURLCreateStringByAddingPercentEscapes(nil, url as CFString!, "!$&'()*+,-./:;=?@_~%#[]" as CFString!, nil, CFStringBuiltInEncodings.UTF8.rawValue)
            if let newUrl = cfUrl {
                if let url = newUrl as? String {
                    return URL(string: url)!
                }
            }
        }
        return nil
    }
    
    class func jsonToString(_ data: [String: Any]) -> String {
        do {
            let resultData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let result = String(data: resultData, encoding: .utf8)
            return result!
        }
        catch {
            return ""
        }
    }
}
