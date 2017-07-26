//
//  StateBar.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/6/20.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class SIXStateBar: UIView {

    let titles: [String]
    let callBack: (_ index: Int) -> Void
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: self.titles)
        segmentedControl.tintColor = .clear
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black,
                                                 NSFontAttributeName: UIFont.systemFont(ofSize: 15)], for: .normal)
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red,
                                                 NSFontAttributeName: UIFont.systemFont(ofSize: 15)], for: .selected)
        segmentedControl.addTarget(self, action: #selector(clickTitle), for: .valueChanged)
        return segmentedControl
    }()
    
    var index: Int {
        set {
            segmentedControl.selectedSegmentIndex = newValue
        }
        get {
            return segmentedControl.selectedSegmentIndex
        }
    }
    
    
    init(titles: [String], callBack: @escaping (_ index: Int) -> Void) {
        self.titles = titles
        self.callBack = callBack
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
 
    func setTitleTextAttributes(attributes: [AnyHashable : Any]?, for state: UIControlState) {
        segmentedControl.setTitleTextAttributes(attributes, for: state)
    }
    
    func clickTitle()  {
        callBack(index)
    }
    
    deinit {
        print("deinit:titlebar")
    }

}
