//
//  GameDetailViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit
import Kingfisher

class GameDetailViewController: UIViewController {
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        navigationItem.largeTitleDisplayMode = .never
        platformView.delegate = self
        releaseInfoView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
    
    
    private lazy var verticalscrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.3)
        return scrollView
    }()
    
    private lazy var headerView: GameHeaderView = {
        let headerView = GameHeaderView(imageUrl: game?.background_image, gameName: game?.name_original ?? "Data not found")
        return headerView
    }()
    
    private lazy var releaseInfoView: ReleaseInfoView = {
        let releaseInfo = ReleaseInfoView(developers: game!.developers, releaseDate: game!.released, website: "\(game!.website!)")
        return releaseInfo
    }()
    
    private lazy var platformView : PlatformView = {
        return PlatformView(stores: (game?.stores)!)
    }()
    
    
    private lazy var screenshotImageViews: [UIImageView] = {
        let screenshotOne = UIImageView()
        let screenshotTwo = UIImageView()
        let screenshotThree = UIImageView()
        
        screenshotOne.kf.setImage(with: game?.background_image)
        screenshotTwo.kf.setImage(with: game?.background_image)
        screenshotThree.kf.setImage(with: game?.background_image)
        
        return [screenshotOne, screenshotTwo, screenshotThree]
    }()
    
    private lazy var screenshotView: ScreenshotView = {
        let screenshotView = ScreenshotView(screenshots: screenshotImageViews, contentWidth: view.frame.width)
        return screenshotView
    }()
    
    private lazy var reviewView: AllReviewView = {
        let reviewView = AllReviewView(reviews: game!.ratings, metacritic: "\(game!.metacritic)")
        return reviewView
    }()
    
    
    private lazy var vStack: UIStackView = {
        let uiStackView = UIStackView(arrangedSubviews: [
            headerView,
            releaseInfoView,
            platformView,
           screenshotView,
            reviewView
            ])
        uiStackView.axis = .vertical
        uiStackView.spacing = 32
        return uiStackView
    }()
    
    
    func layout() {
        view.addSubview(verticalscrollView)
       
        verticalscrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

//            make.top.bottom.edges.equalToSuperview()
//            make.left.edges.equalToSuperview().offset(5)
//            make.right.edges.equalToSuperview().offset(-5)
            
//            make.leading.equalTo(view.snp.leadingMargin).offset(5)
//            make.trailing.equalTo(view.snp.trailingMargin).offset(-5)
//            make.bottom.equalTo(view.snp.bottomMargin).offset(-5)
//            make.top.equalTo(view.snp.topMargin).offset(5)
            
        }
        
        verticalscrollView.addSubview(vStack)
        
        vStack.snp.makeConstraints { make in
            
            make.width.equalToSuperview().offset(10)
            //            make.height.equalTo(100)
        }
        
        platformView.snp.makeConstraints { make in
            make.rightMargin.equalToSuperview().offset(-10)
        }        
    }
}

extension GameDetailViewController: StoreButtonDelegate {
    func storeButtonPressed(link: String) {
        if let url = URL(string: "https://\(link)") {
            UIApplication.shared.openURL(url)
        } else {
            print("Invalid url")
        }
    }
}

extension GameDetailViewController: WebsiteLabelDelegate {
    func labelPressed(link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.openURL(url)
        } else {
            print("Invalid url")
        }

    }
    
    
}
