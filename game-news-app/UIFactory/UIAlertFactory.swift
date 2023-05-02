//
//  UIAlertFactory.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit
//changing fonts -> https://stackoverflow.com/questions/52095864/change-uialertcontrollers-title-fontsize
struct UIAlertFactory {
    static func buildErrorAlert(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: Text.Alert.exitTitle, message: Text.Alert.errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Text.Alert.ok, style: .cancel)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func buildTwoActionAlert(title: String, message: String, actionTitle: String, vc: UIViewController, action: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
       // alert.view.backgroundColor = Colors.backgroundColor
        alert.view.tintColor = Colors.headerText
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
        loadingIndicator.color = Colors.headerText
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        vc.present(alert, animated: true, completion: nil)
    }
}
