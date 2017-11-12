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
    
    func setupMap() {
        let googleCamera = GMSCameraPosition.camera(withTarget: googlePoints[0], zoom: 15)
        //let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 75)
        googleMap = GMSMapView.map(withFrame: self.view.frame, camera: googleCamera)
        googleMap.mapType = .hybrid
        googleMap.settings.myLocationButton = true
        googleMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        googleMap.isMyLocationEnabled = true
        view.addSubview(googleMap)
        setupField()
    }
    func addExpenseButton(){
        expenseButton.frame = CGRect(x: view.frame.midX - 100, y: view.frame.height - 99, width: 200, height: 30)
        expenseButton.setTitle("Рассчитать бюджет", for: .normal)
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
        self.navigationController?.show(vc, sender: self)
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
