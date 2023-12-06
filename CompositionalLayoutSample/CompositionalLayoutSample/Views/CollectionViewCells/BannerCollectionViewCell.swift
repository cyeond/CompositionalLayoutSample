//
//  BannerCollectionViewCell.swift
//  CompositionalLayoutSample
//
//  Created by YD on 12/6/23.
//

import UIKit
import Kingfisher
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    let titleLabel = UILabel()
    let backgroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configure(title: String, imageUrl: String) {
        let url = URL(string: imageUrl)
        
        titleLabel.text = title
        backgroundImageView.kf.setImage(with: url)
    }
}
