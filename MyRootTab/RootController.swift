//
//  RootController.swift
//  MyRootTab
//
//  Created by User on 16/10/12.
//  Copyright © 2016年 User. All rights reserved.
//

import UIKit

class RootController: UIViewController,RootTabBarPro {


    @IBOutlet weak var rootTabBarBottom: NSLayoutConstraint!
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var rootTabBar: RootTabBar!
    weak var blurView:startPublishView!
    weak var blurViewSource:UIView!
    var isStartPublished:Bool!
    weak var home:homeVC!
    var animateFinished:Bool!

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithControllers()
        isStartPublished = false
        animateFinished = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        app_delegate.root_VC = self
        rootTabBar.initDelegate(self)
        rootTabBar.updateTabData(0)
        
    }
    
    func initWithControllers() {
        let home_vc = UIStoryboard.init(name: "home", bundle: nil).instantiateInitialViewController()
        let discover_vc = UIStoryboard.init(name: "discover", bundle: nil).instantiateInitialViewController()
        let message_vc = UIStoryboard.init(name: "message", bundle: nil).instantiateInitialViewController()
        let personal_vc = UIStoryboard.init(name: "personal", bundle: nil).instantiateInitialViewController()
        home = home_vc as! homeVC!
        addChildViewController(home_vc!)
        addChildViewController(discover_vc!)
        addChildViewController(message_vc!)
        addChildViewController(personal_vc!)
        
    }
    
    func btnClick(_ index: Int) {
        let selected_vc = childViewControllers[index]
        selected_vc.view.frame = transitionView.frame
        if selected_vc.view.isDescendant(of: transitionView) {
            transitionView.bringSubview(toFront: selected_vc.view)
        }
        else
        {
            transitionView.addSubview(selected_vc.view)
        }
    }
    
    func popPublish() {
        isStartPublished = true
        setNeedsStatusBarAppearanceUpdate()
        blurViewSource = transitionView.subviews.last!
        let img_data = createBlur()
        if blurView == nil {
            blurView = Bundle.main.loadNibNamed("startPublishView", owner: nil, options: nil)?.first as? startPublishView
            transitionView.addSubview(blurView)
        }
        blurView.initDelegate(self, img_data: img_data)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let rs = isStartPublished == true ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default
        return rs
    }
    
    func dissMissPublish() {
        isStartPublished = false
        setNeedsStatusBarAppearanceUpdate()
        
        if blurView != nil {
            blurView?.removeFromSuperview()
        }
    }
    
    func showTaskVC() {
        rootTabBar.updateTabData(0)
    }
    
    func createBlur() -> (UIImage,CGRect)
    {
        let s_view = blurViewSource
        let rect = CGRect(x: 0,y: 0, width: (s_view?.bounds.size.width)!, height: (s_view?.bounds.size.height)!-48)
        var img = Utils.viewCapture(s_view, rect:rect)
        img = Utils.ciGaussianBlur(img, inputRadius: 8.0)
        return (img!,rect)
    }
    
    func HiddenRootTabBarWithAnimated(_ tf:Bool){
        if animateFinished == false || (tf==false&&rootTabBarBottom.constant==0)||(tf==true&&rootTabBarBottom.constant == -rootTabBar.bounds.size.height)
        {
            return
        }
        let rs = tf == true ? -rootTabBar.bounds.size.height : 0
        let animation_block = {()->Void in
            self.rootTabBarBottom.constant = rs
            self.view.layoutIfNeeded()
        }
        let completion_block = { (isFinish:Bool) -> Void in
            self.animateFinished = true
        }
        UIView.animate(withDuration: 0.2, animations: animation_block, completion: completion_block)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
