//
//  PlatformView.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

class PlatformView: UIView {
    
    private lazy var platformAvailability: UILabel = {
        let label = UILabelFactory.build(text: "Platform availability", font: Fonts.bold(ofSite: 20))
        label.numberOfLines = 0
        label.textColor = Colors.headerText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonContinerView: UIView = {
        let textView: UIView = UIView()
        textView.addCornerRadius(radius: 12)
        //textView.backgroundColor = Colors.textColor
        return textView
    }()

    
    private lazy var psButton: UIButton = {
        let button = UIButtonFactory.build(color: .systemBlue, text: "PS")
//        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
//        button.tapPublisher.flatMap {
//            Just(Tip.tenPercent)
//        }.assign(to: \.value, on: tipSubject)
//            .store(in: &cancelables)
        return button
    }()
    
    private lazy var xBoxButton: UIButton = {
        let button = UIButtonFactory.build(color: .systemGreen, text: "Xbox")
//        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
//        button.tapPublisher.flatMap {
//            Just(Tip.fifteenPercent)
//        }.assign(to: \.value, on: tipSubject)
//            .store(in: &cancelables)
        return button
    }()
    
    private lazy var pcButton: UIButton = {
        let button = UIButtonFactory.build(color: .gray, text: "PC")
//        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
//        button.tapPublisher.flatMap {
//            Just(Tip.twentyPercent)
//        }.assign(to: \.value, on: tipSubject)
//            .store(in: &cancelables)
        return button
    }()
        
    private lazy var hStack: UIStackView = {
        let hStackView: UIStackView = UIStackView(arrangedSubviews: [
            psButton,
            xBoxButton,
            pcButton])
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        hStackView.axis = .horizontal
        
        return hStackView
    }()
    
    private lazy var buttonVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            platformAvailability,
            hStack])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        //stack.backgroundColor = Colors.textColor
        return stack
    }()
    
//
//    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
//    var tipPublisher: AnyPublisher<Tip, Never> {
//        return tipSubject.eraseToAnyPublisher()
//    }
//
//    private var cancelables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
//        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(buttonContinerView)
        buttonContinerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.bottom.leading.trailing.equalToSuperview().offset(10)
//            make.rightMargin.equalToSuperview().offset(10)
        }
        
        buttonContinerView.addSubview(buttonVStack)

        buttonVStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
           // make.edges.equalToSuperview()//            make.top.bottom.trailing.equalToSuperview()//           make.top.bottom.leading.trailing.equalToSuperview()
//            make.rightMargin.equalToSuperview().offset(10)
        }
        
        psButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        xBoxButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        pcButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
//        headerView.snp.makeConstraints { make in
//            make.leading.equalToSuperview()
//            make.trailing.equalTo(buttonVStack.snp.leading).offset(-24)
//            make.width.equalTo(68)
//            make.centerY.equalTo(hStack.snp.centerY)
//            //            make.centerY.equalTo(textFieldContinerView.snp.centerY)
//            //            make.trailing.equalTo(textFieldContinerView.snp.leading).offset(-24)
//        }
    }
    
//    private func observe() {
//        tipSubject.sink { [unowned self] tip in
//            resetView()
//
//            switch tip {
//
//            case .none:
//                break
//            case .tenPercent:
//                tenPerButton.backgroundColor = ThemeColor.secondary
//            case .fifteenPercent:
//                fifteenPerButton.backgroundColor = ThemeColor.secondary
//            case .twentyPercent:
//                twentyPerButton.backgroundColor = ThemeColor.secondary
//            case .custom(value: let value):
//                customPerButton.backgroundColor = ThemeColor.secondary
//                let text = NSMutableAttributedString(string: "$\(value)", attributes: [.font: ThemeFont.bold(ofSite: 20)])
//                text.addAttributes([.font: ThemeFont.bold(ofSite: 14)], range: NSMakeRange(0, 1))
//                customPerButton.setAttributedTitle(text, for: .normal)
//            }
//        }.store(in: &cancelables)
//    }
//    private func resetView() {
//        [tenPerButton, fifteenPerButton, twentyPerButton, customPerButton].forEach {
//            $0.backgroundColor = ThemeColor.primary
//        }
//        let text = NSMutableAttributedString(string: "Custom tip", attributes: [.font:ThemeFont.bold(ofSite: 20)])
//        customPerButton.setAttributedTitle(text, for: .normal)
//    }
//
//    private func handleCustomTipButton() {
//        let alert = UIAlertController(title: "Custom tip", message: "Enter your custom tip", preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Make it rain"
//            textField.keyboardType = .decimalPad
//            textField.autocorrectionType = .no
//            textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.tipTextField.rawValue
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
//            guard let text = alert.textFields?.first?.text, let value = Int(text) else {return}
//            self?.tipSubject.send(.custom(value: value))
//        }
//
//        alert.addAction(addAction)
//        alert.addAction(cancelAction)
//
//        parentViewController?.present(alert, animated: true)
//    }
//
//    func reset() {
//        tipSubject.send(.none)
//    }
}
