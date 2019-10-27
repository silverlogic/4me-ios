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
    
    init(image: UIImage, title: String, value: Float, unit: String, chartImage: UIImage) {
        self.image = image
        self.title = title
        self.value = value
        self.unit = unit
        self.chartImage = chartImage
    }
}

class DashboardCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
}

class DashboardViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    let listItems = [
        ListItem(image: UIImage(named: "InsulinNeedle.png")!,
                 title: "Insuline Injections",
                 value: 0,
                 unit: "units",
                 chartImage: UIImage(named: "GlucoseChart.png")!),
        ListItem(image: UIImage(named: "GlucoseDrop.png")!,
                title: "Glucose Level",
                value: 0,
                unit: "mg/dL",
                chartImage: UIImage(named: "GlucoseChart.png")!),
        ListItem(image: UIImage(named: "DailyCarb.png")!,
                title: "Daily Carbs",
                value: 0,
                unit: "mg",
                chartImage: UIImage(named: "CarbsChart.png")!),
        ListItem(image: UIImage(named: "WeightIcon.png")!,
                title: "Weight",
                value: 0,
                unit: "lbs",
                chartImage: UIImage(named: "WeightChart.png")!),
        ListItem(image: UIImage(named: "Exercise.png")!,
                title: "Exercise",
                value: 0,
                unit: "cal",
                chartImage: UIImage(named: "ExerciseChart.png")!),
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

