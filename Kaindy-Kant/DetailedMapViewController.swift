//
//  DetailedMapViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 06.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import MapKit


class DetailedMapViewController: UIViewController {
    
    @IBOutlet weak var detailedMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMap(latitude: 42.81064, longitude: 74.627359)
    }
    
    func addMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        detailedMap.setRegion(region, animated: true)
    }
}
