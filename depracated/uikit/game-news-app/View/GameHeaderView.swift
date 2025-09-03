//
//  GameHeaderView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit
import Kingfisher

class GameHeaderView: UIView {
    var imageURL: URL?
    var gameName: String
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: imageURL)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var titleLabelView: UILabel = {
        let label = UILabelFactory.build(text: gameName, font: Fonts.bold(ofSite: 30))
        label.numberOfLines = 0
        label.textColor = Colors.headerText
        label.textAlignment = .center
        return label
    }()

   private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleImageView, titleLabelView])
       stackView.axis = .vertical
       stackView.spacing = 4
       return stackView
    }()
    
    init(imageUrl: URL?, gameName: String) {
        self.imageURL = imageUrl
        self.gameName = gameName
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
        
        titleImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
}
