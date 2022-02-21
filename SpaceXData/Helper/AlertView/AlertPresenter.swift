//
//  AlertPresenter.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

//

import Foundation
import UIKit

enum CustomMessage {
    
    static let filterAddMsg = "Do you want to add filter on launch success?"
    static let filterRemoveMsg = "Do you want to remove filter on launch success?"
    static let yes       = "yes"
    static let no        = "no"
    static let appName   = "SpaceX"
    static let ok        = "ok"
}

protocol AlertPresentable {
    func showAlert(title: String?, message: String?, actionTexts: [String], completion:(((Int)->Void))?)
}

extension AlertPresentable where Self: UIViewController {
    
    func showAlert(title: String?, message: String?, actionTexts: [String], completion:(((Int)->Void))?) {
        var actions = [UIAlertAction]()
        
        for index in 0..<actionTexts.count{
            let name = actionTexts[index]
            let action = UIAlertAction(title: name, style: .default, handler: { (UIAlertAction) in
                completion?(index)
            })
            
            actions.append(action)
        }
        showAlert(title, message: message, actions: actions)
    }
    
    func showAlert(_ title: String?, message: String?, actions: [UIAlertAction]) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = actions.compactMap { action -> UIAlertAction in
            controller.addAction(action)
            return action
        }
        self.present(controller, animated: true, completion: nil)
    }
}

extension UIViewController: AlertPresentable {}
