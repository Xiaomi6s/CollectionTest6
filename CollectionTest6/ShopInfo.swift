//
//  ShopInfo.swift
//  CollectionTest6
//
//  Created by rxj on 2017/7/12.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import Foundation

struct ShopInfo {
    let width: Float
    let height: Float
    let img: String
    let price: String
    
    init(dict: [String: Any]) {
        width = dict["w"] as! Float
        height = dict["h"] as! Float
        img = dict["img"] as! String
        price = dict["price"] as! String
    }
}
