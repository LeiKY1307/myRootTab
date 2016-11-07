//
//  startPublishView.swift
//  MyRootTab
//
//  Created by User on 16/10/12.
//  Copyright © 2016年 User. All rights reserved.
//

import UIKit

class startPublishView: UIView {
    weak var delegate:RootController!
    @IBOutlet weak var backgroundView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(startPublishView.dismiss))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        
    }
    
    func initDelegate(_ vc:RootController,img_data:(UIImage,CGRect))
    {
        frame = img_data.1
        delegate = vc
        backgroundView.image = img_data.0
    }
    
    func dismiss()
    {
        delegate.rootTabBar.startPublish(delegate.rootTabBar.publishView)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
