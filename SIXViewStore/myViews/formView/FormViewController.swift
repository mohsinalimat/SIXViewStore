//
//  FormViewController.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/7/26.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        let formView = SIXFormView(titles: ["编号", "姓名", "身份证", "籍贯", "工作年限", "备注"], widths: [40, 60, 150, 150, 70, 150])
        formView.list = list()
        view.addSubview(formView)
        formView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, 0, 0))
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func list() -> [[String]] {
        return Array(repeating: ["0", "王妃", "898988991029394", "塔克拉玛干", "3年", "备注是什么，备注是什么，备注是什么，备注是什么，"], count: 20)
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
