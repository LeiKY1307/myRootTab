//
//  ScrollVC.swift
//  MyRootTab
//
//  Created by User on 16/10/13.
//  Copyright © 2016年 User. All rights reserved.
//

import UIKit

class ScrollVC: UIViewController,UIScrollViewDelegate {
    
    var startContentOffSet:CGFloat = 0
    var lastContentOffSet:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        startContentOffSet = scrollView.contentOffset.y
        lastContentOffSet = startContentOffSet
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset.y
        let differenceFromStart = startContentOffSet - currentOffset
        let differenceFromLast = lastContentOffSet - currentOffset
        lastContentOffSet = currentOffset
        if differenceFromStart < 0 {
            //hide
            if scrollView.isTracking && (fabs(differenceFromLast)>1)
            {
                Operation.HiddenRootTabBar(true)
            }
        }
        else{
            //show
            if scrollView.isTracking && fabs(differenceFromLast)>1
            {
                Operation.HiddenRootTabBar(false)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y<=0
        {
            Operation.HiddenRootTabBar(false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.y<=0)
        {
            Operation.HiddenRootTabBar(false)
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        Operation.HiddenRootTabBar(false)
        return true
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
