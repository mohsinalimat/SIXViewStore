//
//  SIXPageControl.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/22.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class SIXPageControl: UIView {
    
    lazy var normalImage = #imageLiteral(resourceName: "pageControl.png")
    lazy var selectedImage = #imageLiteral(resourceName: "pageControl_selected.png")

//    var dotSize = CGSize(width: 10, height: 10)
    var insets = UIEdgeInsetsMake(10, 25, 10, 25) {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    
    var pageNumber: Int = 0 {
        didSet {
            if self.subviews.isEmpty == false {
                self.subviews.forEach({ $0.removeFromSuperview() })
            }
            for i in 0 ... (pageNumber - 1) {
                let imageView = UIImageView()
                imageView.image = i == 0 ? self.selectedImage : self.normalImage
                self.addSubview(imageView)
                imageView.snp.makeConstraints({ (make) in
                    make.top.equalTo(insets.top)
                    make.bottom.equalTo(-insets.bottom)
                    if i == 0 {
                        make.left.equalTo(insets.left)
                    } else {
                        make.left.equalTo(self.subviews[i - 1].snp.right).offset(10)
                    }
                    if i == pageNumber - 1 {
                        make.right.equalTo(-insets.right)
                    }
                })
            }
        }
    }
    
    var index: Int = 0 {
        didSet {
            guard oldValue < pageNumber && oldValue >= 0 else {
                index = oldValue
                return
            }
            let oldSelectedImageView = self.subviews[oldValue] as! UIImageView
            let newSelectedImageView = self.subviews[index] as! UIImageView
            
            oldSelectedImageView.image = self.normalImage
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                newSelectedImageView.image = self.selectedImage
                UIView.animate(withDuration: 0.4, animations: {
                    self.layoutIfNeeded()
                })
            }
        }
    }
    


}
