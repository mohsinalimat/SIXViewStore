//
//  PageControlViewController.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/26.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController {

    var pageControl1: SIXPageControl!
    var pageControl2: SIXPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        pageControl1 = SIXPageControl()
        pageControl1.pageNumber = 5
        view.addSubview(pageControl1)
        pageControl1.snp.makeConstraints { (make) in
            make.top.equalTo(150)
            make.centerX.equalTo(self.view)
        }
        
        pageControl2 = SIXPageControl()
        pageControl2.insets = UIEdgeInsetsMake(10, 40, 10, 40)
        pageControl2.pageNumber = 5
        pageControl2.layer.cornerRadius = 15
        pageControl2.backgroundColor = UIColor.init(white: 0.85, alpha: 0.3)
        view.addSubview(pageControl2)
        pageControl2.snp.makeConstraints { (make) in
            make.top.equalTo(250)
            make.centerX.equalTo(self.view)
        }
        
        
        let label = UILabel()
        label.text = "点击屏幕，测试"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-200)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pageControl1.index = (pageControl1.index + 1) % pageControl1.pageNumber
        pageControl2.index = (pageControl2.index + 1) % pageControl1.pageNumber
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
