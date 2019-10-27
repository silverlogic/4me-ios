//
//  ConsentViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/27/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class ConsentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionWantHelp(_ sender: Any) {
        self.parent?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dontConsent(_ sender: Any) {
        self.parent?.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
