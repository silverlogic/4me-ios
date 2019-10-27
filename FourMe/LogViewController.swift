//
//  LogViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/27/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textFieldValue: UITextField!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var labelUnit: UILabel!
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    @IBOutlet weak var scannerView: ScannerView!
    
    var listItem: ListItem?
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        if let listItem = self.listItem {
            self.labelTitle.text = "Log \(listItem.logTitle)"
            self.leftImageView.image = listItem.image
            self.labelUnit.text = listItem.unit
            
            if listItem.unit == "mg" {
                self.scannerView.isHidden = false
                self.scannerView.setup()
                self.scannerView.completionHandler = { (barcode) -> Void in self.textFieldValue.text = "39"}
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let listItem = self.listItem, listItem.logTitle != "Carbs" {
            self.textFieldValue.becomeFirstResponder()
        }
    }
    
    @IBAction func actionLog(_ sender: Any) {
        guard let listItem = self.listItem else {
            return
        }
        if listItem.additive {
            listItem.value += Float(self.textFieldValue.text ?? "0") ?? 0
        } else {
            listItem.value = Float(self.textFieldValue.text ?? "0") ?? 0
        }
        self.dismiss(animated: true, completion: self.completionHandler)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification : Notification) {
        
        let duration = (notification as NSNotification).userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber;
        let curve = (notification as NSNotification).userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber;
        let rect = (notification as NSNotification).userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue;
        
        self.view.layoutIfNeeded();
        
        UIView.animate(withDuration: duration.doubleValue, delay: 0, options: UIView.AnimationOptions(rawValue: curve.uintValue), animations: { () -> Void in
            
            self.constraintBottom.constant = rect.cgRectValue.size.height + 40;
            self.view.layoutIfNeeded();
            
            
        }) { (finished) -> Void in
            
        };
        
    }
    
    @objc func keyboardWillHide(_ notification : Notification) {
        
        let duration = (notification as NSNotification).userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber;
        let curve = (notification as NSNotification).userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber;
        
        self.view.layoutIfNeeded();
        
        UIView.animate(withDuration: duration.doubleValue, delay: 0, options: UIView.AnimationOptions(rawValue: curve.uintValue), animations: { () -> Void in
            
            self.constraintBottom.constant = 40
            
        }) { (finished) -> Void in
            
        };
        
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
