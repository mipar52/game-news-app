//
//  LogoView.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    private let gameImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(systemName: Text.UIImages.logoViewImageDpad))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.tintColor = Colors.headerText
        return logoImageView
    }()

    private let topLabel: UILabel = {
        let topLabel = UILabel()
        let text = NSMutableAttributedString(string: Text.UIStrings.game, attributes: [.font: Fonts.semibold(ofSite: 20), .foregroundColor: Colors.textColor])
        topLabel.attributedText = text
        return topLabel
    }()
    
    private let bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        let text = NSMutableAttributedString(string: Text.UIStrings.news, attributes: [.font: Fonts.bold(ofSite: 24), .foregroundColor: Colors.textColor])
        bottomLabel.attributedText = text
        return bottomLabel

    }()
    
    private let animationLabel: UILabel = {
        let animationLabel = UILabel()
        let text = NSAttributedString(string: Text.UIStrings.animationLabel, attributes: [.font: Fonts.regular(ofSite: 18), .foregroundColor: Colors.headerText])
        animationLabel.attributedText = text
        return animationLabel
    }()
    
    private lazy var verticalStackView: UIStackView = {
       let vStack = UIStackView(arrangedSubviews: [
       topLabel,
       bottomLabel,
       animationLabel
       ])
        vStack.axis = .vertical
        vStack.spacing = -4
        return vStack
    }()
                               
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        gameImageView,
        verticalStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
        }()

    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        gameImageView.snp.makeConstraints { make in
           // make.height.equalTo(gameImageView.snp.width)
            make.height.equalTo(100)
        }
    }
}
