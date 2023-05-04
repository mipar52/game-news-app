//
//  UIAlertFactory.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

struct UIAlertFactory {
    static func buildErrorAlert(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: Text.Alert.exitTitle, message: Text.Alert.errorMessage, preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: Text.Alert.exitTitle, attributes: [.font : Fonts.semibold(ofSite: 18), .foregroundColor: Colors.headerText]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: message, attributes: [.font : Fonts.regular(ofSite: 15), .foregroundColor: Colors.textColor]), forKey: "attributedMessage")
        let action = UIAlertAction(title: Text.Alert.ok, style: .cancel)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func buildTwoActionAlert(title: String, message: String, actionTitle: String, vc: UIViewController, action: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alert.view.tintColor = Colors.headerText
        alert.setValue(NSAttributedString(string: title, attributes: [.font : Fonts.semibold(ofSite: 17), .foregroundColor: Colors.headerText]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: message, attributes: [.font : Fonts.regular(ofSite: 14), .foregroundColor: Colors.textColor]), forKey: "attributedMessage")

        let action = UIAlertAction(title: actionTitle, style: .default, handler: action)
        let finish = UIAlertAction(title: Text.Alert.cancel, style: .cancel)
        
        alert.addAction(action)
        alert.addAction(finish)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    static func buildSpinner(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        //alert.view.backgroundColor = Colors.headerText
       alert.view.tintColor = Colors.headerText
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        alert.setValue(NSAttributedString(string: message, attributes: [.font : Fonts.semibold(ofSite: 15), .foregroundColor: Colors.textColor]), forKey: "attributedMessage")

        loadingIndicator.color = Colors.headerText
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        vc.present(alert, animated: true, completion: nil)
    }
}
