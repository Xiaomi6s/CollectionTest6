//
//  ViewController.swift
//  CollectionTest6
//
//  Created by rxj on 2017/7/10.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import UIKit

let cellIdentifier = "CollectionCell"

class ViewController: UIViewController {
    var shops:[ShopInfo] = [ShopInfo]()
   lazy var collectionView: UICollectionView = {
//        let layout = MyFlowLayout()
//        let circleLayout = CircleLayout()
        let waterFlowLayout = XJWaterFlowLayout()
        waterFlowLayout.delegate = self
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: waterFlowLayout);
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "collection"
        view.backgroundColor = UIColor.white
        loadData()
        view.addSubview(collectionView)
        registerCell(ForCollectionView: collectionView)
        collectionView.addFooterRefresh {
            self.loadData()
            self.perform(#selector(self.refresh), with: nil, afterDelay: 2)
        }
        collectionView.refreshFooter?.automaticallyRefresh = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .plain, target: self, action: #selector(rightAction))
        
    }
    @objc func refresh() {
        collectionView.refreshFooter?.endRefresh()
        self.collectionView.reloadData()
    }
    @objc func rightAction() {
        self.navigationController?.pushViewController(NextViewController(), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    func loadData() {
        let path = Bundle.main.path(forResource: "shop", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        for dic in array! {
            let shop = ShopInfo(dict: dic as! [String : Any])
            shops.append(shop)
        }
       
    }
    
    func registerCell(ForCollectionView collection: UICollectionView) {
        collection.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collection.register(UINib(nibName: "ShopCell", bundle: nil), forCellWithReuseIdentifier: "ShopCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionCell
//        cell?.titleLabel.text = "\(indexPath.row)"
        let shop = shops[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as? ShopCell
        let imgUrl = shop.img
        let url = URL(string: imgUrl)
        cell?.imgView.af_setImage(withURL: url!)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.setContentOffset(CGPoint(x: indexPath.row * (150 + 20), y: 0), animated: true)
//        print(indexPath)
    }
    
}

extension ViewController: XJWaterFlowLayoutDelegate {
    func waterFlowLayout(_ layout: XJWaterFlowLayout, heightForItemIndex index: Int, itemWidth: CGFloat) -> CGFloat {
        let shop = shops[index]
        return itemWidth * CGFloat(shop.height) / CGFloat(shop.width)
    }
    func columnNumberInwaterFlowLayout(_ layout: XJWaterFlowLayout) -> Int {
        return 3
    }
}

