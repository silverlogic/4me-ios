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
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // self.performSegue(withIdentifier: "reward", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DashboardCell
        let listItem = self.listItems[indexPath.row]
        cell.leftImageView.image = listItem.image
        cell.topLabel.text = listItem.title
        cell.bottomLabel.text = "\(listItem.value) \(listItem.unit)"
        cell.rightImageView.image = listItem.chartImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = self.listItems[indexPath.row]
        self.performSegue(withIdentifier: "log", sender: listItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listItem = sender as? ListItem {
            let vc = segue.destination as! LogViewController
            vc.listItem = listItem
            vc.completionHandler = {
                self.table.reloadData()
            }
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

