//
//  MyFlowLayout.swift
//  CollectionTest6
//
//  Created by rxj on 2017/7/10.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import UIKit

class MyFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 150, height: 150)
        scrollDirection = .horizontal
        let insert: CGFloat = ((collectionView?.frame.width)! - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: 0, left: insert, bottom: 0, right: insert)
        minimumLineSpacing = 20
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        let centerX = (collectionView?.contentOffset.x)! + (collectionView?.frame.width)! / 2
        for attrs: UICollectionViewLayoutAttributes in array! {
            let delta: CGFloat = fabs(attrs.center.x - centerX)
            let scale = 1 - delta / (collectionView?.frame.width)!
            attrs.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        return array
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
