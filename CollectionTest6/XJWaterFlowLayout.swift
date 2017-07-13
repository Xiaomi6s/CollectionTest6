//
//  XJWaterFlowLayout.swift
//  CollectionTest6
//
//  Created by rxj on 2017/7/12.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import UIKit


/// 默认的列数
private let defaultColumnCount: Int = 3
/// 默认的列之间的间距
private let defaultColumnMargin: CGFloat = 4
/// 默认的行之间的间距
private let defaultRowMargin: CGFloat = 4
/// 默认EdgeInsets
private let defaultEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

class XJWaterFlowLayout: UICollectionViewLayout {
    var delegate: XJWaterFlowLayoutDelegate?
    
    /// 存储最大高度
    private var lastHeight: CGFloat = 0
    /// 存储每列的高度
    private var columnHeghts = [CGFloat]()
    /// 列数
    private var columnCount: Int {
        return delegate?.columnNumberInwaterFlowLayout?(self) ?? defaultColumnCount
    }
    private var attrs = [UICollectionViewLayoutAttributes]()
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: lastHeight)
    }
    override func prepare() {
        super.prepare()
        setupcolumnHeight()
        setupAttrs()
        
    }
    
    /// 初始化存储每列的高度数组
    private func setupcolumnHeight() {
        for _ in 0..<columnCount {
            columnHeghts.append(0)
        }
    }
    
    /// 配置attrs
    private func setupAttrs() {
        attrs.removeAll()
        let count = collectionView?.numberOfItems(inSection: 0)
        for i in 0..<count! {
            let attributes = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            attrs.append(attributes!)
        }
    }
    
    /// 获取最小高度和所在的列数
    ///
    /// - Returns: columIndex：列数 minHeigh：最小高度
    private func minColumHeight() -> (columIndex: Int, minHeigh: CGFloat) {
        let minHeight = columnHeghts.min()
        var columIndex = 0
        for i in 0..<columnHeghts.count {
            if minHeight == columnHeghts[i] {
                columIndex = i
                break
            }
        }
        return (columIndex, minHeight!)
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let collectionViewW = collectionView!.frame.width
        let itemW = (collectionViewW - defaultEdgeInsets.left - defaultEdgeInsets.right - defaultColumnMargin * (CGFloat(columnCount) - 1)) / CGFloat(columnCount)
        let itemH = delegate?.waterFlowLayout(self, heightForItemIndex: indexPath.row, itemWidth: itemW)
        let minColumIndex = minColumHeight().columIndex
        let minHeight = minColumHeight().minHeigh
        let originX = defaultEdgeInsets.left + CGFloat(minColumIndex) * (itemW + defaultColumnMargin)
        let originY = minHeight == 0 ? defaultEdgeInsets.top: defaultRowMargin + minHeight
        attributes.frame = CGRect(x: originX, y: originY, width: itemW, height: itemH!)
        columnHeghts[minColumIndex] = attributes.frame.maxY
        lastHeight = columnHeghts.max()! + defaultEdgeInsets.bottom
        return attributes
    }
}

@objc protocol XJWaterFlowLayoutDelegate: NSObjectProtocol {
    
    /// item的高度
    ///
    /// - Parameters:
    ///   - layout: XJWaterFlowLayout
    ///   - index: 对应的index
    ///   - itemWidth: item的宽
    /// - Returns: item的高度
    func waterFlowLayout(_ layout: XJWaterFlowLayout, heightForItemIndex index: Int, itemWidth: CGFloat) ->CGFloat
    
    /// 配置列数，不实现该方法默认为3
    ///
    /// - Parameter layout: XJWaterFlowLayout
    /// - Returns: 返回列数
    @objc optional func columnNumberInwaterFlowLayout(_ layout: XJWaterFlowLayout) ->Int
}

