//
//  PickerView.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation
import UIKit

enum DefaulFrameSize {
    
    static let pickerViewHeight = CGFloat(300)
    static let toolBarHeight    =  CGFloat(50)
}


protocol ToolbarPickerViewDelegate: AnyObject {
    func didTapDone()
    func didTapCancel()
}

extension ToolbarPickerViewDelegate {
    func didTapCancel(){}
}

class CustomPickerView: UIPickerView {

    weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        
        self.backgroundColor = UIColor.white
        self.setValue(UIColor.black, forKey: "textColor")
        self.autoresizingMask = .flexibleWidth
        self.contentMode = .center
        
    }

    @objc func doneTapped() {
        self.toolbarDelegate?.didTapDone()
    }

    @objc func cancelTapped() {
        self.toolbarDelegate?.didTapCancel()
    }
}



