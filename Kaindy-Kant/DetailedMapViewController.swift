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

class DetailedMapViewController: ViewController {
    
    var googleMap: GMSMapView!
    var googlePoints: [CLLocationCoordinate2D] = []
    var bounds = GMSCoordinateBounds()
    var coordinates: Coordinates?
    var field_id: Int?
    var expenseButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Карта"
        for coordinate in (coordinates?.array)! {
            googlePoints.append(CLLocationCoordinate2D(latitude: (coordinate.latitude as NSString).doubleValue, longitude: (coordinate.longitude as NSString).doubleValue))
            
        }
        setupMap()
        addExpenseButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Карта"
    }
    func setupMap() {
        let googleCamera = GMSCameraPosition.camera(withLatitude: 42.81064, longitude: 74.627359, zoom: 15)
        googleMap = GMSMapView.map(withFrame: self.view.frame, camera: googleCamera)
        googleMap.mapType = .hybrid
        googleMap.settings.myLocationButton = true
        //googleMap.padding = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
        googleMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        googleMap.isMyLocationEnabled = true
        view.addSubview(googleMap)
        setupField()
    }
//    func addGoogleMap() {
//        let camera = GMSCameraPosition.camera(withLatitude: 42.81064, longitude: 74.627359, zoom: 15)
//        map = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//        map.delegate = self
//        map.mapType = .hybrid
//        map.settings.myLocationButton = true
//        map.padding = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
//        map.isMyLocationEnabled = true
//        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(map)
//        fillExistingFields()
//    }
    func addExpenseButton(){
        expenseButton.frame = CGRect(x: view.frame.midX - 100, y: view.frame.height - 99, width: 200, height: 30)
        expenseButton.setTitle("budget".localized(lang: self.lang)!, for: .normal)
        expenseButton.setTitleColor(.white, for: .normal)
        expenseButton.layer.cornerRadius = 5
        expenseButton.backgroundColor = UIColor.init(netHex: Colors.purple)
        expenseButton.addTarget(self, action: #selector(expenseClicked), for: .touchUpInside)
        view.addSubview(expenseButton)
    }
    func expenseClicked(){
        let sb = UIStoryboard(name: "CalculatorExcelViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CalculatorExcelViewController") as! CalculatorExcelViewController
        vc.fieldId = field_id!
        vc.isFromMapViewController = false
        self.navigationController?.show(vc, sender: self)
    }
    func setupField() {
        let path = GMSMutablePath()
        for p in googlePoints {
            bounds = bounds.includingCoordinate(p)
            path.add(p)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        googleMap.animate(with: update)
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
