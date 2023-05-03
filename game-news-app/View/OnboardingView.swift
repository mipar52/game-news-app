//
//  OnboardingView.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit

class OnboardingView: UIView {
    
    private let image: UIImage
    private let title: String
   // private let textAligment: NSTextAlignment
    private let infoDescription: String
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.headerText

        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        UILabelFactory.build(text: title, font: Fonts.bold(ofSite: 16), textColor: Colors.headerText, textAligment: .center)
    }()
    
     lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 5
        label.textColor = Colors.textColor
        let text = NSMutableAttributedString(string: infoDescription, attributes: [.font: Fonts.semibold(ofSite: 15)])
        
      //  text.addAttributes([.font: Fonts.semibold(ofSite: 16)], range: NSMakeRange(text.string.count - 1, 1))
        label.attributedText = text
    //    label.accessibilityIdentifier = amountLabelIdentifier
       // label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [
        imageView,
        UIView(),
        titleLabel,
        descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    init(image: UIImage, title: String, infoDescription: String) {
        self.title = title
        self.image = image
        self.infoDescription = infoDescription
       // self.amountLabelIdentifier = amountLabelIdentifer
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.equalTo(snp.top).offset(24)
//            make.leading.equalTo(snp.leading).offset(24)
//            make.trailing.equalTo(snp.trailing).offset(-24)
//            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
            
        }
    }
    
    @objc func goToGitHubPage(_ sender: OnboardingView) {
        if let url = URL(string: Text.UIStrings.gitHubLink) {
            UIApplication.shared.openURL(url)
        } else {
            print("Invalid link!")
        }
    }

    
//    func configure(amount: Double) {
//        let text = NSMutableAttributedString(string: "Heheh lol", attributes: [.font: Fonts.bold(ofSite: 24)])
//        text.addAttributes([.font: Fonts.bold(ofSite: 16)], range: NSMakeRange(text.string.count - 1, 1))
//        amountLabel.attributedText = text
//    }
}
