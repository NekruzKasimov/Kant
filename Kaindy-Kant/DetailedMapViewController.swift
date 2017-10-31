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
    var coordinates = [Coordinate]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Карта"
        for coordinate in coordinates {
            googlePoints.append(CLLocationCoordinate2D(latitude: (coordinate.latitude as NSString).doubleValue, longitude: (coordinate.longitude as NSString).doubleValue))
        }
        setupMap()
    }
    
    func setupMap() {
        let googleCamera = GMSCameraPosition.camera(withTarget: googlePoints[0], zoom: 15)
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 260)
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
        
        let line = GMSPolyline(path: path)
        let field = GMSPolygon(path: path)
        field.strokeWidth = 2.0
        field.strokeColor = UIColor.green
        field.map = googleMap
        line.strokeWidth = 2
        line.strokeColor = .green
        line.map = googleMap
    }
}
