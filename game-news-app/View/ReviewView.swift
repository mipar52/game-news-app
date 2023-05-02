//
//  ReviewView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class ReviewView: UIView {
    let reviews: [Ratings]
    let metacritic: String
    private lazy var reviewButtons: [UIButton] = {
        var buttons : [UIButton] = []
        
        for review in reviews {
            let reviewName = "\(review.title): "
            let reviewCount = "\(review.count)"
            let button = UIButtonFactory.build(color: Colors.textColor, text: "\(review.title): \(review.count)")
            button.titleLabel?.adjustsFontSizeToFitWidth = true
           // button.backgroundColor = Colors.textColor
            let text = NSMutableAttributedString(string: reviewName.capitalized + reviewCount , attributes: [.font: Fonts.bold(ofSite: 15), .foregroundColor: Colors.headerText])
            
            text.addAttributes([.font: Fonts.bold(ofSite: 15), .foregroundColor: Colors.backgroundColor], range: NSMakeRange(reviewName.count - 1, reviewCount.count + 1))
            button.setAttributedTitle(text, for: .normal)
            buttons.append(button)
        }
        return buttons
    }()
    
    private lazy var metacriticReview: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Metacritic: \(metacritic)", for: .normal)
        button.titleLabel?.font = Fonts.bold(ofSite: 20)
        button.backgroundColor = Colors.headerText
        button.tintColor = Colors.backgroundColor
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    private lazy var goodhStack: UIStackView = {
        let hStackView: UIStackView = UIStackView(arrangedSubviews: Array(reviewButtons[0...reviews.count/2]))
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        hStackView.axis = .horizontal
        
        return hStackView
    }()
    
    private lazy var badhStack: UIStackView = {
        let hStackView: UIStackView = UIStackView(arrangedSubviews: Array(reviewButtons[reviews.count/2..<reviews.count]))
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        hStackView.axis = .horizontal
        return hStackView
    }()
    
    private lazy var buttonVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            goodhStack,
            badhStack,
            metacriticReview])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
            
    init(reviews: [Ratings], metacritic: String) {
        self.reviews = reviews
        self.metacritic = metacritic
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
