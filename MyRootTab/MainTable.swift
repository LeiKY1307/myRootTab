//
//  MainTable.swift
//  MyRootTab
//
//  Created by User on 16/10/14.
//  Copyright © 2016年 User. All rights reserved.
//

import UIKit

class MainTable: UITableView,UIScrollViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var startContentOffset:CGFloat = 0
    var lastContentOffset:CGFloat = 0
    
    func isReturn() -> Bool {
        let tf = false
//        if self.isKind(of: <#T##AnyClass#>) {
//            <#code#>
//        }
        return tf
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isReturn() {
            return
        }
        startContentOffset = scrollView.contentOffset.y
        lastContentOffset = startContentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset.y
        let differenceFromStart = startContentOffset - currentOffset
        let differenceFromLast = lastContentOffset - currentOffset
        lastContentOffset = currentOffset
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
        if isReturn(){
            return
        }
        if scrollView.contentOffset.y<=0
        {
            Operation.HiddenRootTabBar(false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if isReturn(){
            return
        }
        if(scrollView.contentOffset.y<=0)
        {
            Operation.HiddenRootTabBar(false)
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if isReturn(){
            return true
        }
        Operation.HiddenRootTabBar(false)
        return true
    }


}
