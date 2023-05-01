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
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    private lazy var verticalscrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = view.frame.size
        return scrollView
    }()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: game?.background_image)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var titlelabelView: UILabel = {
        let label = UILabelFactory.build(text: game?.name_original, font: Fonts.bold(ofSite: 30))
        label.numberOfLines = 0
        label.textColor = Colors.headerText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var developersLabelView: UILabel = {
        let label = UILabelFactory.build(text: "Developers: \(game?.developers[0].name)", font: Fonts.semibold(ofSite: 15))
        label.numberOfLines = 0
        label.textColor = Colors.textColor
        label.textAlignment = .left
        return label
    }()

    private lazy var releasedlabelView: UILabel = {
        let label = UILabelFactory.build(text: "Release date: \(game!.released)", font: Fonts.semibold(ofSite: 15))
        label.numberOfLines = 0
        label.textColor = Colors.textColor
        label.textAlignment = .left
        return label
    }()

    
    private lazy var vStack: UIStackView = {
        let uiStackView = UIStackView(arrangedSubviews: [
            titleImageView,
            titlelabelView,
            releasedlabelView,
            developersLabelView])
        uiStackView.axis = .vertical
        uiStackView.spacing = 4
        return uiStackView
    }()
    
//    private lazy var developerView: GameDetailView = {
//        return GameDetailView(text: "Developer:\n\(game?.developers.first)")
//    }()
//
//    private lazy var releasedView: GameDetailView = {
//        return GameDetailView(text: "Released:\n\(game?.released)")
//    }()
    
//    private lazy var hStack: UIStackView = {
//        let hstck = UIStackView(arrangedSubviews: [developerView, releasedView])
//        hstck.distribution = .fillEqually
//        hstck.spacing = 16
//        hstck.axis = .horizontal
//        return hstck
//    }()
    
    func layout() {
        view.addSubview(verticalscrollView)
       
        verticalscrollView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.top.equalTo(view.snp.topMargin)
        }
        
        verticalscrollView.addSubview(vStack)
        
        vStack.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview().offset(20)
//            make.height.equalTo(100)
        }
        
//        TODO: make 'billinputview' for platofmrs & reviews
        
        
        titleImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(view.frame.width)
        }
        titlelabelView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(5)
        }
        releasedlabelView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
        }
        developersLabelView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
        }
        
//        verticalscrollView.addSubview(hStack)
        
//        hStack.snp.makeConstraints { make in
//            make.height.equalTo(200)
//            make.width.equalTo(verticalscrollView.frame.width).offset(10)
//        }
       // self.view.addSubview(verticalscrollView)
//        verticalscrollView.snp.makeConstraints { make in
//            make.top.equalTo(verticalscrollView.snp.bottom)
//            make.bottom.left.right.equalToSuperview()
//        }
//
//        verticalscrollView.addSubview(titlelabelView)
//        titlelabelView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(10)
//            make.width.equalToSuperview().multipliedBy(0.8)
//            make.centerX.equalToSuperview()
//        }
    }
}
