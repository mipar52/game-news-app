//
//  ViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

//TODO: -> Create GameDetailVC, add alerts, fix navigation controller, additional -> fix scroll view on HomeVC, add firebase, fix cells on GameListVC

import UIKit

class ViewController: UIViewController {
    let logoView = LogoView()
    let startView = StartView()
    let bottomLabel = UILabelFactory.build(text: Text.UIStrings.bottomLabelStartScreen, font: Fonts.regular(ofSite: 15))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    private lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [
        logoView,
        onboardingScreen,
        startView,
        bottomLabel
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 36
        return verticalStackView
    }()
    
    private var views: [UIView] = {
        var pageViewOne = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: Text.UIStrings.onboardingTitleOne, infoDescription: Text.UIStrings.onboardingTextOne)
        var pageViewTwo = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageTwo)!, title: Text.UIStrings.onboardingTitleTwo, infoDescription: Text.UIStrings.onboardingTextTwo)
        var pageViewThree = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageThree)!, title: Text.UIStrings.oboardingTitleThree, infoDescription: Text.UIStrings.onboardingTextThree)
        var pageViewFour = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageFour)!, title: Text.UIStrings.onboardingTitleFour, infoDescription: Text.UIStrings.onboardingTextFour)
        var pageViewFive = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageFive)!, title: Text.UIStrings.onboardingTitleFive, infoDescription: Text.UIStrings.onboardingTextFive)

        return [pageViewOne, pageViewTwo, pageViewThree, pageViewFour, pageViewFive]
    }()
    
    private lazy var onboardingScreen: GamePageView = {
        let onboardingScreen = GamePageView(contentWidth: view.frame.width - CGFloat(50), views: views)
        return onboardingScreen
    }()
        
    func setupUI() {
        view.backgroundColor = Colors.backgroundColor
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        onboardingScreen.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        startView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        bottomLabel.snp.makeConstraints { make in
          //  make.leading.equalTo(view.snp.leadingMargin).offset(20)
            make.height.equalTo(30)
        }
        bottomLabel.adjustsFontSizeToFitWidth = true
    }
}
