//
//  MoreViewController.swift
//  SIXViewStore
//
//  Created by 刘吉六 on 2017/6/20.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

import UIKit


class MoreViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let width = (UIScreen.main.bounds.width - 10) / 2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 17
        layout.itemSize = CGSize(width: width, height: width*160/340)
        layout.sectionInset = UIEdgeInsetsMake(25, 0, 0, 0)
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height - 49)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.ID)
        return collectionView
    }()
    
    let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "bg12"))
    
    var imageIndex = 0
    
    var models: [Model]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
//        addTapGestureToSwitchBackgroundImage()
        
        createModels()
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapGestureToSwitchBackgroundImage() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(swithBackgroundImage))
        collectionView.addGestureRecognizer(tap)
    }

    func swithBackgroundImage() {
        imageIndex = (1 + imageIndex) % 14
        backgroundImageView.image = UIImage(named: "bg\(imageIndex)")
    }
}

extension MoreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.ID, for: indexPath) as! Cell
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        let model = models[indexPath.item]
        cell.label.text = model.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.item]
        let vc = model.vcClass.init()
        vc.title = model.title
        navigationController!.pushViewController(vc, animated: true)
    }
}

extension MoreViewController {
    
    struct Model {
        let title: String
        let vcClass: UIViewController.Type
    }
    
    class Cell: UICollectionViewCell {
        static let ID = "CELL"
        lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 25)
            self.contentView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.edges.equalTo(UIEdgeInsetsMake(10, 10, 10, 10))
            })
            return label
        }()
    }
}

extension MoreViewController {
    func createModels() {
        models = [
            Model(title: "StateBar", vcClass: StateBarViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
            Model(title: "PageControl", vcClass: PageControlViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
            Model(title: "StateBar", vcClass: StateBarViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
            Model(title: "StateBar", vcClass: StateBarViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
            Model(title: "StateBar", vcClass: StateBarViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
            Model(title: "StateBar", vcClass: StateBarViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
            Model(title: "StateBar", vcClass: StateBarViewController.self),
            Model(title: "CycleView", vcClass: CycleViewController.self),
        
        ]
    }
}
