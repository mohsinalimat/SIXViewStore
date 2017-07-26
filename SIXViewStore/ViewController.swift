//
//  ViewController.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/6/20.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let type = "CycleView"
    
    var titleBar: SIXStateBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        switch type {
            
        case "StateBar":
            newStateBar()
            
        case "CycleView":
            newCycleView()
            
        default:
            break
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: SIXCycleViewDelegate {

    func newCycleView() {
        var images = [String]()
        for i in 1 ... 5 {
            images.append("https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-\(i).jpg")
        }
        
        let cycleView = SIXMultipleCycleView()
        cycleView.setDataArr(images, at: .networkImage)
        cycleView.scrollDirection = .horizontal
        cycleView.placeholderImage = #imageLiteral(resourceName: "img5.jpg")
        cycleView.backgroundColor = .yellow
        cycleView.delegate = self
        view.addSubview(cycleView)
        
        cycleView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 300, height: 150))
        }
    }
    
    func cycleView(_ cycleView: SIXCycleView, didSelectImageAt index: Int) {
        print("item: \(index)")
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
    }
    
    func newStateBar() {
        let titles = ["新闻", "体育", "科技", "娱乐"]
        let titleBar = SIXStateBar(titles: titles) { (index) in
            print(titles[index])
        }
        titleBar.backgroundColor = .yellow
        view.addSubview(titleBar)
        titleBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(100)
            make.height.equalTo(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        self.titleBar = titleBar
        
        newStateBar1()
    }
    
    func newStateBar1() {
        let titles = ["新闻", "早闻天下", "新科技", "娱乐圈", "全球视野", "信息先锋", "博客时代", "天涯", "奇谈怪论"]
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
    }
    
    
    
    
}

