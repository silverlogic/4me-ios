//
//  ToggleButton.swift
//  FourMe
//
//  Created by Lars Klassen on 10/27/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {

    @IBOutlet var relatedButtons: [ToggleButton]?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTarget(self, action: #selector(self.touchUpInsde), for: .touchUpInside)
    }
    
    @objc func touchUpInsde() {
        self.backgroundColor = UIColor(red: 0.027, green: 0.51, blue: 0.74, alpha: 1.0)
        if let relatedButtons = self.relatedButtons {
            for button in relatedButtons {
                button.backgroundColor = UIColor(white: 0.67, alpha: 1.0)
            }
        }
    }

}
