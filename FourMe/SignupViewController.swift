//
//  SignupViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit
import HealthKit

class SignupViewController: UIViewController {

    let healthStore = HKHealthStore();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .height)!,
                            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
                            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!]);
        
        healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
            
        }
        
        // Do any additional setup after loading the view.
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
