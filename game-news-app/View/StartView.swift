//
//  StartView.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit

class StartView: UIView {
    
    private let startLabel: UILabel = {
        UILabelFactory.build(text: Text.UIStrings.findAGame, font: Fonts.semibold(ofSite: 18), textColor: Colors.backgroundColor)
    }()
    
    private let startButton: UIButton = {
       let startButton = UIButton()
        startButton.backgroundColor = Colors.headerText
        startButton.tintColor = Colors.textColor
        startButton.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: Text.UIStrings.pickCategory, attributes: [.font: Fonts.semibold(ofSite: 20), .foregroundColor: Colors.backgroundColor])
        startButton.setAttributedTitle(text, for: .normal)
       // startButton.addTarget(, action: , for: )
        return startButton
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.buttonColor
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [
            startLabel,
            buildSpacerView(height: 0),
            startButton
        ])
        
        vStack.backgroundColor = Colors.textColor
        vStack.spacing = 8
        vStack.axis = .vertical
        return vStack
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func layout() {
        backgroundColor = Colors.textColor
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(off: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
//    @objc func didTapStartButton() {
//        
//        let rootVC = GameGenreSelectTableViewController()
//        Task {
//            do {
//                rootVC.gameGanres = try await manager.getGamesGenres().sorted(by: {$0!.name < $1!.name})
//            } catch {
//                print(error)
//            }
//            let navigationVC = UINavigationController(rootViewController: rootVC)
//            navigationVC.navigationBar.prefersLargeTitles = true
//            //rootVC.title = rootVC.gameResults?.results[0].genres[0].name
//            navigationVC.modalPresentationStyle = .fullScreen
//            present(navigationVC, animated: true)
//        }
//    }
}

