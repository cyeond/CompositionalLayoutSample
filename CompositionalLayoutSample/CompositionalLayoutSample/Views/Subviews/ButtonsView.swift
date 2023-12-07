//
//  ButtonsView.swift
//  CompositionalLayoutSample
//
//  Created by YD on 12/7/23.
//

import UIKit
import SnapKit

class ButtonsView: UIView {
    let buttonsStackView = UIStackView()
    let changeToFirstLayoutButton = UIButton()
    let changeToSecondLayoutButton = UIButton()
    let changeToThirdLayoutButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(buttonsStackView)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.addArrangedSubview(changeToFirstLayoutButton)
        buttonsStackView.addArrangedSubview(changeToSecondLayoutButton)
        buttonsStackView.addArrangedSubview(changeToThirdLayoutButton)
        buttonsStackView.backgroundColor = .black
        
        changeToFirstLayoutButton.setTitle("First", for: .normal)
        changeToFirstLayoutButton.setTitleColor(.white, for: .normal)
        changeToFirstLayoutButton.setTitleColor(.lightGray, for: .highlighted)
        changeToFirstLayoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        changeToFirstLayoutButton.tag = 1
        
        changeToSecondLayoutButton.setTitle("Second", for: .normal)
        changeToSecondLayoutButton.setTitleColor(.white, for: .normal)
        changeToSecondLayoutButton.setTitleColor(.lightGray, for: .highlighted)
        changeToSecondLayoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        changeToSecondLayoutButton.tag = 2
        
        changeToThirdLayoutButton.setTitle("Third", for: .normal)
        changeToThirdLayoutButton.setTitleColor(.white, for: .normal)
        changeToThirdLayoutButton.setTitleColor(.lightGray, for: .highlighted)
        changeToThirdLayoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        changeToThirdLayoutButton.tag = 3
        
        buttonsStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20.0)
        }
    }
}
