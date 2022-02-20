//
//  UIView+Extension.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

import UIKit

extension UIView {
    
    func addConstaintsToCenterVertically() {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self.superview!,
            attribute: .centerY,
            multiplier: 1.0, constant: 0))
    }
    
    func addConstaintsToCenterHorizontally() {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.superview!,
            attribute: .centerX,
            multiplier: 1.0, constant: 0))
    }
    
    func addConstraintsToFitToSuperview() {
        guard let superView = self.superview else { return  }
        self.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    

    
    private func prepareForConstraints() {
           self.translatesAutoresizingMaskIntoConstraints = false
           if superview == nil {
               assert(false, "You need to have a superview before you can add contraints")
           }
       }
    
}
