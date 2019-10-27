//
//  ConsentViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/27/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit
import HealthKit

class ConsentViewController: UIViewController {

    let healthStore = HKHealthStore();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionWantHelp(_ sender: Any) {
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .height)!,
                            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
                            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!]);
        
        healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
            DispatchQueue.main.async {
                self.parent?.dismiss(animated: true, completion: nil)
            }
        }
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
