//
//  GameDetailView.swift
//  game-news-app
//
//  Created by Milan Parađina on 01.05.2023..
//

import UIKit

class GameDetailView:UIView {
    var text: String
    
    private lazy var textFieldContinerView: UIView = {
        let textView: UIView = UIView()
        textView.addCornerRadius(radius: 12)
        textView.backgroundColor = Colors.textColor
        return textView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabelFactory.build(text: text, font: Fonts.semibold(ofSite: 20))
        label.textColor = Colors.backgroundColor
        return label
    }()

    init(text: String) {
        self.text = text
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(textFieldContinerView)
        textFieldContinerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContinerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
         //   make.leading.equalTo(currencyDenomLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContinerView.snp.trailing).offset(-16)
        }
    }
    
    
}
