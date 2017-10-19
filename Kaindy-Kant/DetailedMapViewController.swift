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
    
    var googleMap: GMSMapView!
    var googlePoints: [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Карта"
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.81064, longitude: 74.627359))
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.807869, longitude: 74.6294193))
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.811612, longitude: 74.6309217))
        googlePoints.append(CLLocationCoordinate2D(latitude: 42.81064, longitude: 74.627359))
        setupMap()
    }
    
    func setupMap() {
        let googleCamera = GMSCameraPosition.camera(withTarget: googlePoints[0], zoom: 15)
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        googleMap = GMSMapView.map(withFrame: frame, camera: googleCamera)
        googleMap.mapType = .hybrid
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
        field.map = googleMap
        
        let line = GMSPolyline(path: path)
        line.strokeWidth = 2
        line.strokeColor = .green
        line.map = googleMap
    }
}
