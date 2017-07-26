//
//  CycleViewController.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/25.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class CycleViewController: UIViewController, SIXCycleViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        var localImages = [String]()
        for i in 0 ... 7 {
            localImages.append("img\(i).jpg")
        }
        
        var networkImages = [String]()
        for i in 1 ... 5 {
            networkImages.append("https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-\(i).jpg")
        }
        
        var slice = localImages[0 ... 3]
        let localImageCycleView = SIXCycleView()
        localImageCycleView.dataArr = Array(slice)
        
        slice = localImages[4 ... localImages.count-1]
        let localImageCycleView1 = SIXMultipleCycleView()
        localImageCycleView1.setDataArr(Array(slice), at: .localImage)
        localImageCycleView1.scrollDirection = .vertical
        
        let networkImageCycleView1 = SIXMultipleCycleView()
        networkImageCycleView1.setDataArr(networkImages, at: .networkImage)
        
        let textCycleView = SIXMultipleCycleView()
        textCycleView.setDataArr(networkImages, at: .text)
        textCycleView.scrollDirection = .vertical
        textCycleView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        view.addSubview(localImageCycleView)
        view.addSubview(networkImageCycleView1)
        view.addSubview(localImageCycleView1)
        view.addSubview(textCycleView)
        
        for (index, cycleView) in view.subviews.enumerated() {
            (cycleView as! SIXCycleView).delegate = self
            
            cycleView.snp.makeConstraints({ (make) in
                make.left.right.equalTo(0)
                make.top.equalTo(self.view.snp.top).offset(index * 160 + 64)
                make.height.equalTo(index == view.subviews.count-1 ? 50 : 140)
            })
        }
        
    }
    
    func cycleView(_ cycleView: SIXCycleView, didSelectImageAt index: Int) {
        print("item: \(index)")
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
