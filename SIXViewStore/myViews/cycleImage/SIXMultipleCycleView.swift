//
//  SIXMultipleCycleView.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/15.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class SIXMultipleCycleView: SIXCycleView {

    enum Mode {
        case localImage   //default
        case networkImage
        case text
    }
    
    //指明 轮播内容的类别（本地图片、网络图片、文字）
    var mode: Mode = .localImage
    
    //滑动方向（上、下）
    var scrollDirection: UICollectionViewScrollDirection {
        set{
            flowLayout.scrollDirection = newValue
        }
        get {
            return flowLayout.scrollDirection
        }
    }
    
    //网络图片模式下的展位图
    var placeholderImage: UIImage?
    
    /*
        mode：localImage，    dataArr的元素是图片名称
        mode：networkImage，  dataArr的元素是图片网络地址
        mode：text，          dataArr的元素是文本内容
    */
    func setDataArr(_ dataArr: [String], at mode: Mode) {
        self.mode = mode
        //dataArr的didSet方法中会刷新collectionView及设置pageControl
        self.dataArr = dataArr
        
        if mode == .text && pageControl != nil {
            pageControl!.removeFromSuperview()
            pageControl = nil
        }
    }
    
    
    
    override func scrollToItem(item: Int) {
        var indexPath: IndexPath
        if item >= totalItemCount {
            indexPath = IndexPath(item: totalItemCount / 2, section: 0)
        } else {
            indexPath = IndexPath(item: item, section: 0)
        }
        if scrollDirection == .horizontal {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
    
    override func currentItem() -> Int {
        var item: Int
        if scrollDirection == .horizontal {
            item = Int((collectionView.contentOffset.x + collectionView.bounds.width * 0.5) / collectionView.bounds.width)
        } else {
            item = Int((collectionView.contentOffset.y + collectionView.bounds.height * 0.5) / collectionView.bounds.height)
        }
        return max(0, item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch mode {
        case .localImage:
            return super.collectionView(collectionView, cellForItemAt: indexPath)
            
        case .networkImage:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.ID, for: indexPath) as! Cell
            let dataIndex = indexPath.item % dataArr.count
            let url = URL(string: dataArr[dataIndex])
            cell.imageView.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(ImageTransition.fade(1))])
            return cell
            
        case .text:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.ID, for: indexPath) as! Cell
            let dataIndex = indexPath.item % dataArr.count
            cell.textLabel.text = dataArr[dataIndex]
            return cell
        }
    }
    
}
