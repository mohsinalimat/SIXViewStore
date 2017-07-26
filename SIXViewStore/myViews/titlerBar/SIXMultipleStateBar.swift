//
//  StateBar1.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/6/28.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class SIXMultipleStateBar: SIXStateBar {

    var lineHeight: CGFloat = 1
    //修改左右边距
    var horMargin: CGFloat = 0
    //标题间距
    var space: CGFloat = 15
    
    var lineColor: UIColor? {
        set {
            self.lineView.backgroundColor = newValue
        }
        get {
            return self.lineView.backgroundColor
        }
    }
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .red
        return lineView
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate var labels = [UILabel]()
    
    
    override func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(lineView)
        
        segmentedControl.apportionsSegmentWidthsByContent = true
        for i in 0 ..< titles.count {
            segmentedControl.setContentOffset(CGSize(width: space, height: 0), forSegmentAt: i)
        }
    }
    
    override var bounds: CGRect {
        didSet {
            scrollView.frame = bounds
            scrollView.contentInset = UIEdgeInsetsMake(0, horMargin, 0, horMargin)
            segmentedControl.sizeToFit()
            segmentedControl.center = CGPoint(x: segmentedControl.center.x, y: scrollView.center.y)
            scrollView.contentSize = CGSize(width: segmentedControl.bounds.width + 2 * space, height: 0)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                self.lineView.frame = self.calculateFrameForLineView(index: self.index)
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func clickTitle() {
        super.clickTitle()
        
        moveLine()
    }

    func moveLine() {
        let labelMidX = calculateFrameForLineView(index: index).midX
        let contentSizeWith = scrollView.contentSize.width
        let scrollViewWidth = scrollView.frame.width
        
        let leftBounds = labelMidX > scrollViewWidth * 0.5
        let rightBounds = labelMidX < contentSizeWith - scrollViewWidth * 0.5
        
        var x:CGFloat = 0
        if leftBounds, rightBounds {
            x = labelMidX - scrollViewWidth * 0.5
        } else if !leftBounds {
            x = -horMargin
        } else if !rightBounds {
            x = contentSizeWith - scrollViewWidth + horMargin
        }
        
        UIView.animate(withDuration: 0.25) { 
            self.lineView.frame = self.calculateFrameForLineView(index: self.index)
            self.scrollView.contentOffset = CGPoint(x: x, y: 0)
        }
    }
    
    func calculateFrameForLineView(index: Int) -> CGRect {
        let label = self.titleLabelForIndex(index)
        var frame = label.convert(label.bounds, to: scrollView)
        frame.origin.y = scrollView.frame.height - 2 * lineHeight
        frame.size.height =  lineHeight
        return frame
    }
}

extension SIXMultipleStateBar {
    
    func titleLabelForIndex(_ index: Int) -> UILabel {
        if labels.isEmpty {
            let tempArr = findSubViews(view: segmentedControl)
            for view in tempArr {
                if view is UILabel {
                    labels.append(view as! UILabel)
                }
            }
        }
        
        let title = titles[index]
        var selectedLabel: UILabel!
        for label in labels {
            if label.text == title {
                selectedLabel = label
            }
        }
        return selectedLabel
    }
    
    func findSubViews(view: UIView) -> [UIView] {
        var subViewArr = [UIView]()
        
        if view.subviews.isEmpty {
            subViewArr.append(view)
        } else {
            for subView in view.subviews {
                subViewArr.append(contentsOf: findSubViews(view: subView))
            }
        }
        return subViewArr
    }
}
