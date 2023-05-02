//
//  AllReviewView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class AllReviewView: UIView {
    
    private lazy var reviewlabelView: UILabel = {
        let label = UILabelFactory.build(text: "Game reviews", font: Fonts.bold(ofSite: 20))
        label.numberOfLines = 0
        label.textColor = Colors.headerText
        label.textAlignment = .center
        return label
    }()

    
    private lazy var reviewView: ReviewView = {
        let reviewView = ReviewView()
        return reviewView
    }()

   private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [reviewlabelView, reviewView])
       vStack.axis = .vertical
       vStack.spacing = 4
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
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
