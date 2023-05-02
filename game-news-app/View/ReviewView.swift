//
//  ReviewView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class ReviewView: UIView {
    
    
    private lazy var reviewOne: UIButton = {
        let button = UIButtonFactory.build(color: Colors.textColor, text: "Meh: 50")
        return button
    }()
    
    private lazy var reviewTwo: UIButton = {
        let button = UIButtonFactory.build(color: Colors.textColor, text: "Cool: 50")
        return button
    }()
    
    private lazy var reviewThree: UIButton = {
        let button = UIButtonFactory.build(color: Colors.textColor, text: "Meh: 50")
        return button
    }()
    
    private lazy var metacriticReview: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = Fonts.bold(ofSite: 20)
        button.backgroundColor = Colors.headerText
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let hStackView: UIStackView = UIStackView(arrangedSubviews: [
            reviewOne,
            reviewTwo,
            reviewThree])
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        hStackView.axis = .horizontal
        
        return hStackView
    }()
    
    private lazy var buttonVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            hStack,
            metacriticReview])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
            
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(buttonVStack)
        
        buttonVStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
