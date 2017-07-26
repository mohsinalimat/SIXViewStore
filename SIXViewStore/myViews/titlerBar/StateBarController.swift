//
//  TitleViewController.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/25.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class StateBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titles = ["新闻", "体育", "科技", "娱乐"]
        let titleBar = SIXStateBar(titles: titles) { (index) in
            print(titles[index])
        }
        titleBar.backgroundColor = .yellow
        view.addSubview(titleBar)
        titleBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(200)
            make.height.equalTo(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        titles = ["新闻", "早闻天下", "新科技", "娱乐圈", "全球视野", "信息先锋", "博客时代", "天涯", "奇谈怪论"]
        let titleBar1 = SIXMultipleStateBar(titles: titles) { (index) in
            print(titles[index])
        }
        titleBar1.backgroundColor = .yellow
        titleBar1.lineHeight = 2
        view.addSubview(titleBar1)
        titleBar1.snp.makeConstraints { (make) in
            make.centerY.equalTo(300)
            make.height.equalTo(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }

        // Do any additional setup after loading the view.
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
