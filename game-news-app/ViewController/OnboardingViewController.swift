//
//  OnboardingViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

//TODO: -> error handling, firebase, readme

import UIKit

class OnboardingViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDefault.bool(forKey: K.isUserOnboarded) {
            self.getGameCategories()
        }
        
        setupUI()
        startView.delegate = self
        userDefault.set(false, forKey: K.isUserOnboarded)
    }
    
    override func viewDidLayoutSubviews() {
        onboardingScreen.resizeScrollViewContentSize()
        onboardingScreen.reconfigureViews()
    }
    
    private lazy var logoView: LogoView = {
        let logoView = LogoView()
        return logoView
    }()
    
    private lazy var startView : StartView = {
        let startView = StartView()
        return startView
    }()
    
    private lazy var bottomLabel: UILabel = {
        let bottomLabel = UILabelFactory.build(text: Text.UIStrings.bottomLabelStartScreen, font: Fonts.regular(ofSite: 15))
        return bottomLabel
    }()

    private var views: [UIView] = {
        var pageViewOne = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: Text.UIStrings.onboardingTitleOne, infoDescription: Text.UIStrings.onboardingTextOne)
        var pageViewTwo = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageTwo)!, title: Text.UIStrings.onboardingTitleTwo, infoDescription: Text.UIStrings.onboardingTextTwo)
        var pageViewThree = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageThree)!, title: Text.UIStrings.oboardingTitleThree, infoDescription: Text.UIStrings.onboardingTextThree)
        var pageViewFour = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageFour)!, title: Text.UIStrings.onboardingTitleFour, infoDescription: Text.UIStrings.onboardingTextFour)
        
        var pageViewFive = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageFive)!, title: Text.UIStrings.onboardingTitleFive, infoDescription: Text.UIStrings.onboardingTextFive)
        
        let text = NSMutableAttributedString(string: Text.UIStrings.onboardingTextFive, attributes: [.font: Fonts.semibold(ofSite: 15)])
        
        if let url = URL(string: Text.UIStrings.gitHubLink) {
            text.addAttributes([.font: Fonts.semibold(ofSite: 15), .foregroundColor: Colors.textColor, .link: url], range: NSMakeRange(Text.UIStrings.onboardingTextFive.count - 6, 5))
            pageViewFive.isUserInteractionEnabled = true
            pageViewFive.addGestureRecognizer(UITapGestureRecognizer(target: pageViewFive, action: #selector(pageViewFive.goToGitHubPage(_:))))
            pageViewFive.descriptionLabel.attributedText = text
        }
        
        return [pageViewOne, pageViewTwo, pageViewThree, pageViewFour, pageViewFive]
    }()
    
    private lazy var onboardingScreen: GamePageView = {
        let onboardingScreen = GamePageView(contentWidth: view.frame.width, views: views)
        return onboardingScreen
    }()

    
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
           // make.width.equalTo(view.snp.width)
            make.height.equalTo(200)
        }
        
        startView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        bottomLabel.adjustsFontSizeToFitWidth = true
    }
}

extension OnboardingViewController: StartButtonDelegate {
    func startButtonPressed(_ sender: UIButton) {
        getGameCategories()
    }
}

extension OnboardingViewController {
    func getGameCategories() {
        UIAlertFactory.buildSpinner(message: Text.Alert.categories, vc: self)
            Task {
                do {
                    let gameGanresResults = try await NetworkManager.sharedInstance.getGamesGenres()
                    self.dismiss(animated: true, completion: { [unowned self] in
                        switch gameGanresResults {
                            
                        case .success(let success):
                            if let gameGanres = success {
                                let rootVC = GameGenreSelectTableViewController()
                                rootVC.gameGanres = gameGanres.sorted(by: {$0.name < $1.name})
                                self.userDefault.set(true, forKey: K.isUserOnboarded)
                                let navigationVC = UINavigationController(rootViewController: rootVC)
                                    navigationVC.navigationBar.prefersLargeTitles = true
                                    navigationVC.modalPresentationStyle = .fullScreen
                                self.present(navigationVC, animated: true)
                            }
                            
                        case .failure(let failure):
                            print(failure)
                            UIAlertFactory.buildErrorAlert(message: Text.Alert.errorMessage, vc: self)
                        }
                    })
                } catch {
                    self.dismiss(animated: true, completion: {
                        UIAlertFactory.buildErrorAlert(message: Text.Alert.errorMessage, vc: self)
                            print(error)
                    })
                }
            }
    }

}
