//
//  ListCollectionViewCell.swift
//  CompositionalLayoutSample
//
//  Created by YD on 12/6/23.
//

import UIKit
import Kingfisher
import SnapKit

class ListCollectionViewCell: UICollectionViewCell {
    static let identifier = "ListCollectionViewCell"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10.0)
            $0.height.equalTo(100.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(10.0)
            $0.height.equalTo(30.0)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(10.0)
            $0.height.equalTo(30.0)
        }
    }
    
    func configure(title: String, subtitle: String, imageUrl: String) {
        let url = URL(string: imageUrl)
        
        imageView.kf.setImage(with: url)
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
