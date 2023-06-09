//
//  ReleaseInfoView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class ReleaseInfoView: UIView {
    let developers: [Developers]
    let releaseDate: String
    let website: String
    var delegate: WebsiteLabelDelegate?
    
    private lazy var developersLabelView: UILabel = {
        let label = UILabelFactory.build(text: "", font: Fonts.semibold(ofSite: 20), textColor: Colors.headerText)
        let developedBy = "Developers: "
        let text = NSMutableAttributedString(string: developedBy + "\(developers.first!.name)" , attributes: [.font: Fonts.semibold(ofSite: 20), .foregroundColor: Colors.headerText])
        
        text.addAttributes([.font: Fonts.bold(ofSite: 20), .foregroundColor: Colors.textColor], range: NSMakeRange(developedBy.count - 1, developers.first!.name.count + 1))
        
        label.attributedText = text
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var releasedlabelView: UILabel = {
        let label = UILabelFactory.build(text: "", font: Fonts.semibold(ofSite: 20), textColor: Colors.headerText)
        let released = "Release date: "
        let text = NSMutableAttributedString(string: released + releaseDate , attributes: [.font: Fonts.semibold(ofSite: 20), .foregroundColor: Colors.headerText])
        
        text.addAttributes([.font: Fonts.bold(ofSite: 20), .foregroundColor: Colors.textColor], range: NSMakeRange(released.count - 1, releaseDate.count + 1))
        label.attributedText = text
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var websiteLabelView: UILabel = {
        let label = UILabelFactory.build(text: "", font: Fonts.semibold(ofSite: 20), textColor: Colors.headerText)
        var stringUrl = website
        let gameWebsite = "Website: "
        let text = NSMutableAttributedString(string: gameWebsite + website , attributes: [.font: Fonts.semibold(ofSite: 20), .foregroundColor: Colors.headerText])
        
        if let url = URL(string: stringUrl) {
            text.addAttributes([.font: Fonts.bold(ofSite: 15), .foregroundColor: Colors.textColor, .link: url], range: NSMakeRange(gameWebsite.count - 1, website.count + 1))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToWebsite(sender:))))
        }
        label.attributedText = text
        label.adjustsFontSizeToFitWidth = true
        
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [developersLabelView, releasedlabelView, websiteLabelView])
        vStack.axis = .vertical
        vStack.spacing = 4
        return vStack
    }()
    
    init(developers: [Developers], releaseDate: String, website: String) {
        self.developers = developers
        self.releaseDate = releaseDate
        self.website = website
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
    @objc private func goToWebsite(sender: UILabel) {
        self.delegate?.labelPressed(link: website)
    }
}

