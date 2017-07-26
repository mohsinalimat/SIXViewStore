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
                    make.top.equalTo(5)
                    make.bottom.equalTo(-5)
                    if i == 0 {
                        make.left.equalTo(15)
                    } else {
                        make.left.equalTo(self.subviews[i - 1].snp.right).offset(10)
                    }
                    if i == pageNumber - 1 {
                        make.right.equalTo(-15)
                    }
                })
            }
        }
    }
    
    var index: Int {
        set {
            guard newValue < pageNumber && newValue >= 0 else {
                return
            }
            let oldSelectedImageView = self.subviews[self.index] as! UIImageView
            let newSelectedImageView = self.subviews[newValue] as! UIImageView
            
            oldSelectedImageView.image = self.normalImage
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                newSelectedImageView.image = self.selectedImage
                UIView.animate(withDuration: 0.4, animations: {
                    self.layoutIfNeeded()
                })
            }
            self.index = newValue
        }
        get {
            return self.index
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.index = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
