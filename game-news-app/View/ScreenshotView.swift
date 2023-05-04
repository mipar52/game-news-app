//
//  ScreenshotView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class ScreenshotView: UIView {
    let screenshotImageView: [UIView]
    let contentWidth: CGFloat
    
    private lazy var gameScreenshotsTitleView: UILabel = {
            let label = UILabelFactory.build(text: "Gameplay screenshots", font: Fonts.bold(ofSite: 20))
            label.numberOfLines = 0
            label.textColor = Colors.headerText
            label.textAlignment = .center
            return label
    }()
    
     lazy var screenshotView: GamePageView = {
        let gameView = GamePageView(contentWidth: contentWidth,views: screenshotImageView)
        return gameView
    }()

    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [gameScreenshotsTitleView, screenshotView])
        vStack.axis = .vertical
        vStack.spacing = 8
        return vStack
    }()
    
    init(screenshots: [UIView], contentWidth: CGFloat) {
        self.screenshotImageView = screenshots
        self.contentWidth = contentWidth
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
