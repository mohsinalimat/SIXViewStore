//
//  SIXCycleView.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/13.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

protocol SIXCycleViewDelegate {
    func cycleView(_ cycleView: SIXCycleView, didSelectImageAt index: Int)
}

class SIXCycleView: UIView {
    
    //图片or文字数据录入
    var dataArr = [String]() {
        didSet {
            collectionView.reloadData()
            pageControl?.numberOfPages = dataArr.count
        }
    }
    //自动滑动的开关
    var isAutoScroll = true {
        didSet {
            stopTimer()
        }
    }
    //图片切换间隔
    var timeInterval: TimeInterval = 2
    
    var delegate: SIXCycleViewDelegate?
    
    
    var collectionView: UICollectionView!
    
    var flowLayout: UICollectionViewFlowLayout!
    
    //如需修改pageControl位置，可以通过更新它的约束实现
    var pageControl: UIPageControl?
    
    var timer: Timer?
    
    var totalItemCount: Int {
        return self.dataArr.count * 100
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.ID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        addSubview(collectionView)
        
        pageControl = UIPageControl()
        addSubview(pageControl!)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        pageControl!.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(0)
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            stopTimer()
        }
    }
    
    override func didMoveToWindow() {
        startTimer()
    }
    
    func startTimer() {
        guard isAutoScroll else { return }
        
        stopTimer()
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        timer!.fire()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timerAction() {
        if collectionView.bounds.width == 0 || collectionView.bounds.height == 0 || [0, 1].contains(dataArr.count) {
            return
        }
        scrollToItem(item: currentItem() + 1)
    }
    
    func scrollToItem(item: Int) {
        var indexPath: IndexPath
        if item >= totalItemCount {
            indexPath = IndexPath(item: totalItemCount / 2, section: 0)
        } else {
            indexPath = IndexPath(item: item, section: 0)
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func currentItem() -> Int {
        guard collectionView.bounds.width != 0 else {
            return 0
        }
        let item = (collectionView.contentOffset.x + collectionView.bounds.width * 0.5) / collectionView.bounds.width
        return max(0, Int(item))
    }
}

extension SIXCycleView:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.ID, for: indexPath) as! Cell
        let imageIndex = indexPath.item % dataArr.count
        cell.imageView.image = UIImage.init(named: dataArr[imageIndex])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleView(self, didSelectImageAt: indexPath.item % dataArr.count)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let pageControl = pageControl {
            let index = currentItem() % dataArr.count
            if index != pageControl.currentPage {
                pageControl.currentPage = index
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}


extension SIXCycleView {
    
    class Cell: UICollectionViewCell {
        
        static var ID: String = "SIXCycleCell"
        
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            self.contentView.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.edges.equalTo(0)
            })
            return imageView
        }()
        
        lazy var textLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            self.contentView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.bottom.equalTo(0)
                make.right.equalTo(-15)
            })
            return label
        }()
        
    }
}
















