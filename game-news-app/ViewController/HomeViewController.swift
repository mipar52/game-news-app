//
//  ViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import UIKit

class ViewController: UIViewController {
    let manager = NetworkManager()
    let logoView = LogoView()
    var pageView : GamePageView?
    let startView = StartView()
    let bottomLabel = UILabelFactory.build(text: Text.UIStrings.bottomLabelStartScreen, font: Fonts.regular(ofSite: 15))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        pageView = GamePageView(frame: CGRect(x: 200, y: 200, width: view.frame.width, height: 200))
        setupUI()
    }
    
    private lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [
        logoView,
        pageView!,
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
        pageView!.snp.makeConstraints { make in
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
