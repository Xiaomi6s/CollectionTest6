//
//  NextViewController.swift
//  CollectionTest6
//
//  Created by 任晓健 on 2017/7/17.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    lazy var waterFallView: XJWaterFallView = {
        let waterFall = XJWaterFallView(frame: view.bounds)
        waterFall.wateFalldelegate = self
        return waterFall
    }()
    var shops:[ShopInfo] = [ShopInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
         loadData()
        view.addSubview(waterFallView)
        waterFallView.addFooterRefresh {
            self.loadData()
            self.perform(#selector(self.refresh), with: nil, afterDelay: 2)
        }
        waterFallView.refreshFooter?.automaticallyRefresh = true
    }
    
    @objc func refresh() {
        waterFallView.refreshFooter?.endRefresh()
        self.waterFallView.reloadData()
    }
    
    func loadData() {
        let path = Bundle.main.path(forResource: "shop", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        for dic in array! {
            let shop = ShopInfo(dict: dic as! [String : Any])
            shops.append(shop)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension NextViewController: XJWaterFallViewDelegate {
    func numberInWaterFallView(_ waterFallView: XJWaterFallView) -> Int {
        return shops.count
    }
    func waterFallView(_ waterFallView: XJWaterFallView, cellForItem index: Int) -> XJWaterFallViewCell {
        let shop = shops[index]
        let cell = waterFallView.dequeueReusableCell(withReuseIdentifier: "XJWaterFallViewCell", for: IndexPath(row: index, section: 0)) as? XJWaterFallViewCell
        let imgUrl = shop.img
        let url = URL(string: imgUrl)
        cell?.imgView.af_setImage(withURL: url!)
        cell?.textLabel.text = shop.price
        return cell!
    }
    func waterFallView(_ waterFallView: XJWaterFallView, heightForItemAt index: Int, withItemWidth itemWidth: CGFloat) -> CGFloat {
        let shop = shops[index]
        return itemWidth * CGFloat(shop.height) / CGFloat(shop.width)
    }

    
    
}
