//
//  AllReviewView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class AllReviewView: UIView {
    let reviews: [Ratings]
    let metacritic: String
    private lazy var reviewlabelView: UILabel = {
        let label = UILabelFactory.build(text: "Game reviews", font: Fonts.bold(ofSite: 20))
        label.numberOfLines = 0
        label.textColor = Colors.headerText
        label.textAlignment = .center
        return label
    }()

    
    private lazy var reviewView: ReviewView = {
        let reviewView = ReviewView(reviews: reviews, metacritic: metacritic)
        return reviewView
    }()

   private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [reviewlabelView, reviewView])
       vStack.axis = .vertical
       vStack.spacing = 4
       return vStack
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
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
