//
//  PopoverViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/27/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    @IBOutlet weak var viewOuterBox: UIView!
    @IBOutlet weak var viewBottomBox: UIView!
    
    @IBOutlet weak var imageViewtop: UIImageView!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelMiddle: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var imageViewSplash: UIImageView!
    @IBOutlet weak var imageViewWalmartGiftCard: UIImageView!
    @IBOutlet weak var imageViewAppleWallet: UIImageView!
    
    var completionHandler: (() -> Void)?
    var popover: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewOuterBox.layer.cornerRadius = 10
        self.viewBottomBox.layer.cornerRadius = 10
        
        if let popover = self.popover {
            if popover == "giftCard" {
                self.imageViewtop.image = UIImage(named: "CreditCard.png")
                self.labelTop.text = "Congratulations!\nYou've earned a"
                self.labelMiddle.text = ""
                self.labelBottom.text = ""
                self.imageViewWalmartGiftCard.isHidden = false
                self.imageViewAppleWallet.isHidden = false
            } else if popover == "food" {
                self.imageViewtop.image = UIImage(named: "FoodModalIcon.png")
                self.labelTop.text = ""
                self.labelMiddle.text = ""
                self.labelBottom.text = "What about some scrambled\neggs with spinach for your\nnext lunch?"
                self.imageViewSplash.isHidden = false
            } else {
                self.imageViewtop.image = UIImage(named: "RewardModalIcon.png")
                self.labelTop.text = "Great work!\nYou've earned"
                self.labelMiddle.text = "50"
                self.labelBottom.text = "points"
            }
        }
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: completionHandler)
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
