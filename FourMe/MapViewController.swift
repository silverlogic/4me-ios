//
//  MapViewController.swift
//  FourMe
//
//  Created by Lars Klassen on 10/27/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var constraintLegend: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewGrabber: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewGrabber.layer.cornerRadius = 4
        
        let center = CLLocationCoordinate2DMake(36.1032017, -115.1670873)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 2000, longitudinalMeters: 2000)
        self.mapView.setRegion(region, animated: false)
        self.mapView.delegate = self
        
        let firstPin = MKPointAnnotation()
        firstPin.coordinate = CLLocationCoordinate2DMake(36.1082017, -115.1670873)
        firstPin.title = "La Favorita Market"
        self.mapView.addAnnotation(firstPin)
        
        let secondPin = MKPointAnnotation()
        secondPin.title = "Green Valley Grocery"
        secondPin.coordinate = CLLocationCoordinate2DMake(36.1042017, -115.1630873)
        self.mapView.addAnnotation(secondPin)
    }
    
    var legendToggled = false
    @IBAction func actionLegend(_ sender: Any) {
        self.view.layoutIfNeeded()
        if !legendToggled {
            UIView.animate(withDuration: 0.3) {
                self.constraintLegend.constant = 0
                self.view.layoutIfNeeded()
            }
            self.legendToggled = true
        } else {
            UIView.animate(withDuration: 0.3) {
                self.constraintLegend.constant = 200
                self.view.layoutIfNeeded()
            }
            self.legendToggled = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"

        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }

        if let annotationView = annotationView {
            // Configure your annotation view here
            if annotation.title == "La Favorita Market" {
                annotationView.image = UIImage(named: "MapIcon_Blue.png")
            } else {
                annotationView.image = UIImage(named: "MapIcon_Orange.png")
            }
        }

        return annotationView
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
