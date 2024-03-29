//
//  DashboardViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class ListItem: NSObject {
    let image: UIImage
    let title: String
    var value: Float
    let unit: String
    let chartImage: UIImage
    let logTitle: String
    let additive: Bool
    
    init(image: UIImage, title: String, value: Float, unit: String, chartImage: UIImage, logTitle: String, additive: Bool) {
        self.image = image
        self.title = title
        self.value = value
        self.unit = unit
        self.chartImage = chartImage
        self.logTitle = logTitle
        self.additive = additive
    }
}

class DashboardCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
}

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var constraintScore: NSLayoutConstraint!
    @IBOutlet weak var labelSavings: UILabel!
    @IBOutlet weak var labelSavingsSubtitle: UILabel!
    @IBOutlet weak var labelDaysUntil: UILabel!
    @IBOutlet weak var circleDaysUntil: CircleView!
    @IBOutlet weak var labelMgUntil: UILabel!
    @IBOutlet weak var circleMgUntil: CircleView!
    @IBOutlet weak var imageViewStar: UIImageView!
    
    let listItems = [
        ListItem(image: UIImage(named: "InsulinNeedle.png")!,
                 title: "Insuline Injections",
                 value: 0,
                 unit: "units",
                 chartImage: UIImage(named: "GlucoseChart.png")!,
                 logTitle: "Insuline Injection",
                 additive: true),
        ListItem(image: UIImage(named: "GlucoseDrop.png")!,
                title: "Glucose Level",
                value: 0,
                unit: "mg/dL",
                chartImage: UIImage(named: "GlucoseChart.png")!,
                logTitle: "Glucose Level",
                additive: false),
        ListItem(image: UIImage(named: "DailyCarb.png")!,
                title: "Daily Carbs",
                value: 0,
                unit: "mg",
                chartImage: UIImage(named: "CarbsChart.png")!,
                logTitle: "Carbs",
                additive: true),
        ListItem(image: UIImage(named: "WeightIcon.png")!,
                title: "Weight",
                value: 0,
                unit: "lbs",
                chartImage: UIImage(named: "WeightChart.png")!,
                logTitle: "Weight",
                additive: false),
        ListItem(image: UIImage(named: "Exercise.png")!,
                title: "Exercise",
                value: 0,
                unit: "cal",
                chartImage: UIImage(named: "ExerciseChart.png")!,
                logTitle: "Exercise",
                additive: true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.circleDaysUntil.progressValue = 0
        self.circleMgUntil.progressValue = 0
    }
    
    var showedSignup = false
    override func viewDidAppear(_ animated: Bool) {
        if !self.showedSignup {
            self.showedSignup = true
            self.performSegue(withIdentifier: "signup", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DashboardCell
        let listItem = self.listItems[indexPath.row]
        cell.leftImageView.image = listItem.image
        cell.topLabel.text = listItem.title
        cell.bottomLabel.text = "\(Int(listItem.value)) \(listItem.unit)"
        cell.rightImageView.image = listItem.chartImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = self.listItems[indexPath.row]
        self.performSegue(withIdentifier: "log", sender: listItem)
    }
    
    var showMealPopup = false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listItem = sender as? ListItem {
            if listItem.logTitle == "Glucose Level" {
                self.showMealPopup = true
            }
            let vc = segue.destination as! LogViewController
            vc.listItem = listItem
            vc.completionHandler = {
                self.table.reloadData()
                let score = self.currentScore + 50
                self.setScore(score: score <= 2000 ? score : 2000)
                if listItem.logTitle == "Carbs" {
                    self.labelMgUntil.text = "\(Int(listItem.value))"
                    self.circleMgUntil.progressValue = listItem.value / 130.0 as NSNumber
                }
                
                self.performSegue(withIdentifier: "popover", sender: "points")
            }
        } else if let popover = sender as? String {
            let vc = segue.destination as! PopoverViewController
            vc.popover = popover
            if popover == "points" {
                if self.showMealPopup {
                    self.showMealPopup = false
                    vc.completionHandler = {
                        self.performSegue(withIdentifier: "popover", sender: "food")
                    }
                }
            }
        }
    }
    
    var currentScore: Float = 0
    let maxScoreWidth: Float = 210.0
    let maxScore: Float = 2000
    func setScore(score: Float) {
        self.currentScore = score
        self.constraintScore.constant = CGFloat(self.currentScore / self.maxScore * self.maxScoreWidth)
        self.labelScore.text = "\(Int(self.currentScore)) points"
        if score == 2000 {
            self.imageViewStar.isHidden = false
        } else {
            self.imageViewStar.isHidden = true
        }
    }
    
    var timeHasPassed = false
    func updateDataAfterTime() {
        self.labelSavings.text = "$53"
        self.labelDaysUntil.text = "13"
        self.circleDaysUntil.progressValue = 0.8
        self.labelMgUntil.text = "75"
        self.circleMgUntil.progressValue = 75 / 130.0 as NSNumber
        self.setScore(score: 1950)
        self.timeHasPassed = true
        
        listItems[0].value = 64
        listItems[1].value = 203
        listItems[2].value = 75
        listItems[3].value = 178
        listItems[4].value = 360
        
        self.table.reloadData()
    }

    @IBAction func actionTapScore(_ sender: Any) {
        if self.currentScore == 2000 {
            self.performSegue(withIdentifier: "popover", sender: "giftCard")
            self.setScore(score: 0)
        }
    }
    
    var showingSavingsYear = false
    @IBAction func actionSavings(_ sender: Any) {
        if !showingSavingsYear {
            self.labelSavings.text = "$847"
            self.labelSavingsSubtitle.text = "ANNUAL\nINSULIN\nSAVINGS"
            self.showingSavingsYear = true
        } else {
            self.labelSavings.text = self.timeHasPassed ? "$53" : "$0"
            self.labelSavingsSubtitle.text = "MONTHLY\nINSULIN\nSAVINGS"
            self.showingSavingsYear = false
        }
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

