//
//  RootTabBar.swift
//  MyRootTab
//
//  Created by User on 16/10/12.
//  Copyright © 2016年 User. All rights reserved.
//

import UIKit

@objc protocol RootTabBarPro {
    func btnClick(_ index:Int)
    func popPublish()
    func dissMissPublish()
}

let start_index = 100
let maxBtns = 5
let publish_index = 2
let selectImgKey = "select"
let selectedImgKey = "selected"
let labelKey = "label"
let select_color = UIColor.white
let selected_color = UIColor.yellow

class RootTabBar: UIView {

    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var publishView: UIView!
    @IBOutlet weak var circleView_width: NSLayoutConstraint!
    @IBOutlet weak var publishView_width: NSLayoutConstraint!
    var locked:Bool!
    var selectIndex:Int!
    weak var delegate:RootTabBarPro!
    
    var last_index:Int?// 保存点击中间按钮之前的索引
    
    var UIData:Array<Dictionary<String,String>>!
    
    
    var isChoosePublish:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isChoosePublish = false
        locked = false
        selectIndex = -1
        backgroundColor = UIColor.clear
        circleView.layer.cornerRadius = circleView_width.constant / 2.0
        circleView.clipsToBounds = true
        publishView.layer.cornerRadius = publishView_width.constant / 2.0
        publishView.clipsToBounds = true
        
        publishView.isUserInteractionEnabled = true
        publishView.backgroundColor = selected_color
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(RootTabBar.tapPublish(_:)))
        publishView.addGestureRecognizer(tap)
        
        // 设置TabBar icon 和 标题
        let dict_0 = [selectImgKey:"home_btn_normal",selectedImgKey:"home_btn_pressed",labelKey:"首页"]
        let dict_1 = [selectImgKey:"discover_btn_normal",selectedImgKey:"discover_btn_pressed",labelKey:"发现"]
        let dict_2 = [labelKey:"发布"]
        let dict_3 = [selectImgKey:"msg_btn_normal",selectedImgKey:"msg_btn_pressed",labelKey:"消息"]
        let dict_4 = [selectImgKey:"me_btn_normal",selectedImgKey:"me_btn_pressed",labelKey:"我"]
        UIData = [dict_0,dict_1,dict_2,dict_3,dict_4]
        
        for i in 0 ..< maxBtns {
            let btn:UIView = viewWithTag(i+start_index)!
            btn.isUserInteractionEnabled = true
            let dict = UIData[i]
            for sub_view in btn.subviews {
                if sub_view.isKind(of: UILabel.self) {
                    let labelView = sub_view as! UILabel
                    labelView.text = dict[labelKey]
                    break
                }
            }
            if i == publish_index {
                continue
            }
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(RootTabBarPro.btnClick(_:)))
            tap.numberOfTapsRequired = 1
            btn.addGestureRecognizer(tap)
            if i == 0 {
                let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(RootTabBar.homeScrollTop))
                doubleTap.numberOfTapsRequired = 2
                btn.addGestureRecognizer(doubleTap)
                tap.require(toFail: doubleTap)
            }
        }
        
        
    }
    
    func homeScrollTop(){
        if selectIndex != 0 {
            
        } else {
            
        }
    }
    
    func initDelegate(_ vc:RootTabBarPro) {
        delegate = vc
    }
    
    func updateTabData(_ new_index:Int) {
        let root_vc = delegate as! RootController
        if selectIndex == new_index && root_vc.transitionView.subviews.count != 0 {
            return
        }
        updateUI(new_index)
        _ = delegate as! RootController
        if selectIndex == publish_index {
            //if isChoosePublish == true {
                delegate.dissMissPublish()
                publishAnimate(0.0, a_view: publishView, comletion: nil)
            //}
            //isChoosePublish = false
        }
        selectIndex = new_index
        let rs = selectIndex > publish_index ? selectIndex-1:selectIndex
        delegate.btnClick(rs!)
    }
    
    func updateUI(_ new_index:Int) {
        for i in 0 ..< maxBtns {
            let btn:UIView = self.viewWithTag(i+start_index)!
            let dict = UIData[i]
            for sub_view in btn.subviews {
                let text_color = i == new_index ? selected_color : select_color
                let imgName = i == new_index ? dict[selectedImgKey] : dict[selectImgKey]
                if sub_view.isKind(of: UILabel.self) {
                    let labelView = sub_view as! UILabel
                    labelView.textColor = text_color
                }
                else if sub_view.isKind(of: UIImageView.self) {
                    let imgView = sub_view as! UIImageView
                    imgView.image = UIImage.init(named: imgName!)
                }
            }
        }
    }
    
    func btnClick(_ tap:UITapGestureRecognizer!)  {
        let new_index = tap.view!.tag - start_index
        updateTabData(new_index)
    }
    
    func tapPublish(_ tap:UITapGestureRecognizer!)
    {
        startPublish(tap.view!)
    }
    
    func startPublish(_ tapView:UIView!) {
        if locked == true {
            return
        }
        locked = true
        
        //if isChoosePublish == false {
            last_index = selectIndex == publish_index ? last_index : selectIndex
            selectIndex = publish_index
            let radians = atan2(tapView.transform.b, tapView.transform.a)
            let degrees = radians * (180 / CGFloat(M_PI))
            let startPublished = degrees == 0 ? true : false
            let angle = degrees == 0 ? 45.0 : 0.0
            let completion_block = { (isFinish:Bool) -> Void in
                var rs_index:Int!
                if startPublished == true {
                    self.delegate.popPublish()
                    rs_index = self.selectIndex
                }
                else {
                    self.delegate.dissMissPublish()
                    rs_index = self.last_index
                }
                self.updateUI(rs_index)
                self.locked = false
            }
            publishAnimate(angle, a_view: tapView, comletion: completion_block)
            //isChoosePublish = true
        //}
    }
    
    func publishAnimate(_ angle:Double!,a_view:UIView!,comletion:((Bool) -> Void)?) {
        let animation_block = { () -> Void in
            self.viewRotation(angle, a_view: a_view)
        }
        UIView.animate(withDuration: 0.2, animations: animation_block, completion: comletion)
    }
    
    func viewRotation(_ angle:Double!,a_view:UIView!) {
        a_view.transform = CGAffineTransform(rotationAngle: CGFloat(angle*M_PI)/180.0)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
