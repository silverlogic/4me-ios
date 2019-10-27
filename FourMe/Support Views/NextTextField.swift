//
//  NextTextField.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class NextTextField: UITextField, UITextFieldDelegate {

    @IBOutlet weak var nextField : UIView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = self.nextField as? UITextField {
            nextField.becomeFirstResponder()
        } else if let nextField = self.nextField as? UIButton {
            nextField.sendActions(for: .touchUpInside)
        }
        
        return true
    }
}
