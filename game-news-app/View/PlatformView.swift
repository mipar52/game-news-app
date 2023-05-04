//
//  PlatformView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class PlatformView: UIView {
    let stores : [Stores]
    var delegate: StoreButtonDelegate?
    
    private lazy var platformAvailability: UILabel = {
        let label = UILabelFactory.build(text: "Game store availability", font: Fonts.bold(ofSite: 20))
        label.numberOfLines = 0
        label.textColor = Colors.headerText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonContinerView: UIView = {
        let textView: UIView = UIView()
        textView.addCornerRadius(radius: 12)
        return textView
    }()
    
    private lazy var storeButtons: [UIButton] = {
        var buttons : [UIButton] = []
        
        for i in 0..<stores.count {
            let button = UIButtonFactory.build(color: Colors.headerText, text: stores[i].store.name)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.textColor = Colors.headerText
            button.titleLabel?.font = Fonts.semibold(ofSite: 15)
            button.tag = i
            button.addTarget(self, action: #selector(goToStore(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }()
        
    private lazy var hStackOne: UIStackView = {
        let hStackView: UIStackView = UIStackView(arrangedSubviews: Array(storeButtons[0...storeButtons.count/2]))
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        hStackView.axis = .horizontal
        
        return hStackView
    }()
    
    private lazy var hStackTwo: UIStackView = {
        let hStackView: UIStackView = UIStackView(arrangedSubviews: Array(storeButtons[storeButtons.count/2..<storeButtons.count]))
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        hStackView.axis = .horizontal
        
        return hStackView
    }()
    
    private lazy var buttonVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            platformAvailability,
            hStackOne,
            hStackTwo])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    init(stores: [Stores]) {
        self.stores = stores
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(buttonContinerView)
        buttonContinerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buttonContinerView.addSubview(buttonVStack)
        buttonVStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func goToStore(sender: UIButton) {
      self.delegate?.storeButtonPressed(link: stores[sender.tag].store.domain)
    }
}
