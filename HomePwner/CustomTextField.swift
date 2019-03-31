//
//  CustomTextField.swift
//  HomePwner
//
//  Created by Tyler Percy on 3/31/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        borderStyle = .bezel
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        borderStyle = .roundedRect
        return super.resignFirstResponder()
    }
}
