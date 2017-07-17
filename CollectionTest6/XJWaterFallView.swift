//
//  XJWaterFallView.swift
//  CollectionTest6
//
//  Created by 任晓健 on 2017/7/17.
//  Copyright © 2017年 renxiaojian. All rights reserved.
//

import UIKit

class XJWaterFallView: UICollectionView {
    var wateFalldelegate: XJWaterFallViewDelegate?
    init(frame: CGRect) {
        let waterFlowLayout = XJWaterFlowLayout()
        super.init(frame: frame, collectionViewLayout: waterFlowLayout)
         waterFlowLayout.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.dataSource = self
        self.delegate = self;
        self.backgroundColor = UIColor.white
        registerCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCell() {
        register(XJWaterFallViewCell.self, forCellWithReuseIdentifier: "XJWaterFallViewCell")
    }
}

extension XJWaterFallView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wateFalldelegate?.numberInWaterFallView(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.wateFalldelegate?.waterFallView(self, cellForItem: indexPath.row) ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.wateFalldelegate?.waterFallView?(self, didSelectItemAt: indexPath.row)
    }
}

extension XJWaterFallView: XJWaterFlowLayoutDelegate {
    func waterFlowLayout(_ layout: XJWaterFlowLayout, heightForItemIndex index: Int, itemWidth: CGFloat) -> CGFloat {
        return self.wateFalldelegate?.waterFallView(self, heightForItemAt: index, withItemWidth: itemWidth) ?? 0
    }
    func columnNumberInwaterFlowLayout(_ layout: XJWaterFlowLayout) -> Int {
        return self.wateFalldelegate?.columnNumberInWaterFallView?(self) ?? 3
    }
}

@objc protocol XJWaterFallViewDelegate: NSObjectProtocol {
    
    /// 配置数据源
    ///
    /// - Parameter waterFallView: waterFallView
    /// - Returns: 返回item的个数
    func numberInWaterFallView(_ waterFallView: XJWaterFallView) ->Int
    
    /// 配置数据源
    ///
    /// - Parameter waterFallView: waterFallView
    /// - Returns: 返回列数
    @objc optional func columnNumberInWaterFallView(_ waterFallView: XJWaterFallView) ->Int
    
    /// 配置Cell
    ///
    /// - Parameters:
    ///   - waterFallView: waterFallView
    ///   - index: item的序号
    /// - Returns: 返回cell
    func waterFallView(_ waterFallView: XJWaterFallView, cellForItem index: Int) ->XJWaterFallViewCell
    
    /// 点击item的事件
    ///
    /// - Parameters:
    ///   - waterFallView: waterFallView
    ///   - index: 点击item的序号
    /// - Returns:
    @objc optional func waterFallView(_ waterFallView: XJWaterFallView, didSelectItemAt index: Int)
    
    /// 配置item的高度
    ///
    /// - Parameters:
    ///   - waterFallView: waterFallView
    ///   - index: item的序列
    ///   - itemWidth: item的宽
    /// - Returns: 返回item的高度
    func waterFallView(_ waterFallView: XJWaterFallView, heightForItemAt index: Int, withItemWidth itemWidth: CGFloat) ->CGFloat
}

class XJWaterFallViewCell: UICollectionViewCell {
    var imgView: UIImageView = UIImageView()
    var textLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        imgView.backgroundColor = UIColor.gray
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.textColor = UIColor.red
        self.addSubview(imgView)
        self.addSubview(textLabel)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        textLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-4)
            make.bottom.equalTo(-2)
        }
    }

}
