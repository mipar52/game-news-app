//
//  StartView.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit
import Combine
import CombineCocoa

class StartView: UIView {
    
    var delegate: StartButtonDelegate?
    
    private let startLabel: UILabel = {
        UILabelFactory.build(text: Text.UIStrings.findAGame, font: Fonts.semibold(ofSite: 18), textColor: Colors.backgroundColor)
    }()
    
    private let startButton: UIButton = {
       let startButton = UIButton()
        startButton.backgroundColor = Colors.headerText
        startButton.tintColor = Colors.textColor
        startButton.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: Text.UIStrings.pickCategory, attributes: [.font: Fonts.semibold(ofSite: 20), .foregroundColor: Colors.backgroundColor])
        startButton.setAttributedTitle(text, for: .normal)
        startButton.addTarget(self, action: #selector(searchForCategories), for: .touchUpInside)
        return startButton
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.buttonColor
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [
            startLabel,
            buildSpacerView(height: 0),
            startButton
        ])
        
        vStack.backgroundColor = Colors.textColor
        vStack.spacing = 8
        vStack.axis = .vertical
        return vStack
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func layout() {
        backgroundColor = Colors.textColor
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
          //  let width = vStackView.snp.width as! CGFloat
        }
        
        addShadow(off: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    @objc func searchForCategories() {
        self.delegate?.startButtonPressed(startButton)
    }
}


