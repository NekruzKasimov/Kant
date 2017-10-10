//
//  DetailedMapViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 06.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class DetailedMapViewController: UIViewController {
    
    @IBOutlet weak var detailedMap: MKMapView!
    var googleMap: GMSMapView!
    var googlePoints: [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.81064, longitude: 74.627359))
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.807869, longitude: 74.6294193))
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.811612, longitude: 74.6309217))
        setupMap()
    }
    
    func setupMap() {
        let googleCamera = GMSCameraPosition.camera(withTarget: googlePoints[0], zoom: 15)
        googleMap = GMSMapView.map(withFrame: detailedMap.frame, camera: googleCamera)
        googleMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(googleMap)
        
        setupField()
    }
    
    func setupField() {
        let path = GMSMutablePath()
        
        for p in googlePoints {
            path.add(p)
        }
        
        let field = GMSPolygon(path: path)
        field.strokeWidth = 2.0
        field.map = googleMap
    }
}
