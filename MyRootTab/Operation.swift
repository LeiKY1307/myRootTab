//
//  Operation.swift
//  PanArt
//
//  Created by zsly on 16/4/8.
//  Copyright © 2016年 zsly. All rights reserved.
//

import UIKit


class Operation: NSObject {

    
    class func getWindow() -> UIView{
        return UIApplication.shared.windows.last!
    }
    class func getAppdelegate() -> AppDelegate{
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        return app_delegate
    }
    

    //MARK: - 是否隐藏底部TabBar
    class func HiddenRootTabBar(_ tf:Bool){
        Operation.getAppdelegate().root_VC.HiddenRootTabBarWithAnimated(tf)
    }
    
}

