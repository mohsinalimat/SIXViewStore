//
//  YGSFormView.swift
//  yingu
//
//  Created by liujiliu on 2017/6/1.
//  Copyright © 2017年 Yingu-corp. All rights reserved.
//

//        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0), green: CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0), alpha: 1)

import UIKit


class YGSFormView: UIView {
    
    //view
    var leftTableView: UITableView!
    var rightScrollView: UIScrollView!
    var rightTableView: UITableView!
    
    //other
    var titles: [String]
    let widths: [CGFloat]
    
    var list = [[String]]() {
        didSet {
            if self.superview != nil {
                self.leftTableView.reloadData()
                self.rightTableView.reloadData()
            }
        }
    }

    
    init(titles: [String], widths: [CGFloat]) {
        self.titles = titles
        self.widths = widths
        YGSFormViewCell.lineCount = titles.count - 1
        YGSFormViewCell.widths = widths
        YGSFormViewCell.widths.removeFirst()
        
        super.init(frame: .zero)
        
        contructUI()
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contructUI() {
        leftTableView = UITableView(frame: .zero, style: .plain)
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.separatorStyle = .none
        leftTableView.backgroundColor = nil
        addSubview(leftTableView)
        
        rightScrollView = UIScrollView()
        addSubview(rightScrollView)

        rightTableView = UITableView(frame: .zero, style: .plain)
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.separatorStyle = .none
        rightTableView.backgroundColor = nil
        rightScrollView.addSubview(rightTableView)
        
        subviews.forEach { (view) in
            if let scrollView =  view as? UIScrollView {
                scrollView.showsVerticalScrollIndicator = false
                scrollView.showsHorizontalScrollIndicator = false
            }
        }
        
        leftTableView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(0)
            make.width.equalTo(widths.first!)
        }
        rightScrollView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(0)
            make.left.equalTo(leftTableView.snp.right)
        }
        rightTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
            make.height.equalTo(rightScrollView.snp.height)
            make.width.equalTo(widths.reduce(0, +) - widths.first!)
        }
    }

}

extension YGSFormView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("1:" + tableView.description)
        print("\(list.count)")
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list = self.list
        
        print("2:" + tableView.description)
        if leftTableView === tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
            cell.selectionStyle = .none
            cell.textLabel?.text = list[indexPath.row].first
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = .white
            cell.backgroundColor = (indexPath.row % 2 == 0) ? .yellow : .green
            return cell
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "YGSFormViewCell") as? YGSFormViewCell
        if cell == nil {
            cell = YGSFormViewCell.init(style: .default, reuseIdentifier: "YGSFormViewCell")
            cell!.setTextColor(color: .white, font: 14)
            cell!.selectionStyle = .none
        }
        cell!.backgroundColor = (indexPath.row % 2 == 0) ? .yellow : .green
        list[indexPath.row].removeFirst()
        cell!.setTexts(texts: list[indexPath.row])
        return cell!
    }
}

extension YGSFormView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var titles = self.titles
        
        if tableView == leftTableView {
            let contentView = UIView()
            contentView.backgroundColor = .yellow
            
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .white
            label.text = titles.first!
            contentView.addSubview(label)
            
//            label.snp.makeConstraints({ (make) in
//                make.left.equalTo(8)
//                make.centerY.equalTo(contentView)
//            })
            
            return contentView
        }
        
        let titleView = YGSFormViewCell(style: .default, reuseIdentifier: nil)
        titles.removeFirst()
        titleView.setTexts(texts: titles)
        titleView.setTextColor(color: .white, font: 14)
        titleView.backgroundColor = .yellow
        return titleView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == leftTableView {
            rightTableView.contentOffset = scrollView.contentOffset
        }
        
        if scrollView == rightTableView {
            leftTableView.contentOffset = scrollView.contentOffset
        }
    }
}

class YGSFormViewCell: UITableViewCell {
    
    static var lineCount: Int = 0
    static var widths: [CGFloat] = [0.0]
    
    var labels = [UILabel]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contructUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTexts(texts: [String]) {
        for (index, text) in texts.enumerated() {
            labels[index].text = text
        }
    }
    
    func setTextColor(color: UIColor, font: CGFloat) {
        labels.forEach { (label) in
            label.textColor = color
            label.font = UIFont.systemFont(ofSize: font)
        }
    }
    
    func contructUI() {
        for i in 0..<YGSFormViewCell.lineCount {
            
            let label = UILabel()
            label.textAlignment = .center
            contentView.addSubview(label)
            
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(contentView)
                make.width.equalTo(YGSFormViewCell.widths[i])
                if i == 0 {
                    make.left.equalTo(0)
                } else {
                    make.left.equalTo(labels.last!.snp.right)
                }
            })
            labels.append(label)
        }
    }
    
    
    
    
    
}
















