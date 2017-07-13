//
//  CircleLayout.swift
//  CollectionTest6
//
//  Created by rxj on 2017/7/12.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import UIKit

class CircleLayout: UICollectionViewLayout {
    
    var attributes: [UICollectionViewLayoutAttributes] {
        var attributes = [UICollectionViewLayoutAttributes]()
        let count = self.collectionView?.numberOfItems(inSection: 0)
        for i in 0..<count!{
            let indexPath = IndexPath(item: i, section: 0)
            let attrs = layoutAttributesForItem(at: indexPath)
            attributes.append(attrs!)
        }
        return attributes
    }
    override func prepare() {
        super.prepare()
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let count = collectionView?.numberOfItems(inSection: 0)
        let centerX = (collectionView?.frame.size.width)! / 2
        let centerY = (collectionView?.frame.size.height)! / 2
        let angle = 2 * Double.pi / Double(count!) * Double(indexPath.row)
        let radius: CGFloat = 100
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.center = CGPoint(x: centerX +  radius * CGFloat(sin(angle)), y: centerY + radius * CGFloat(cos(angle)))
        attrs.size = CGSize(width: 60, height: 60)
        return attrs
    }
}
