//
//  ToolBar.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 21/02/22.
//

import Foundation
import UIKit

class CustomToolbar: UIToolbar {
    
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
    
        self.barStyle = .default
        self.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        
    }
    
    @objc func onDoneButtonTapped() {
        self.toolbarDelegate?.didTapDone()
    }
    
}
