//
//  PickerView.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation
import UIKit

enum DefaulFrameSize: CGFloat {
    
    case pickerViewHeight = 300
    case toolBarHeight =  50
}


protocol ToolbarPickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

extension ToolbarPickerViewDelegate {
    func didTapCancel(){}
}

class CustomPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

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


class CustomToolbar: UIToolbar {
    
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
    
        self.barStyle = .default
        self.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        
    }
    
    @objc func onDoneButtonTapped() {
        self.toolbarDelegate?.didTapDone()
    }
    
}
