//
//  MapViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 02.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import GoogleMaps
import SVProgressHUD
import SkyFloatingLabelTextField

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    struct MapCoordinate {
        var coordinate: CLLocationCoordinate2D
        var number: Int
    }

    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var mapView: UIView!
    var isMapViewAdded = false
    @IBOutlet weak var fieldId: SkyFloatingLabelTextField! {
        didSet {
            fieldId.accessibilityIdentifier = "fieldId"
            GlobalFunctions.configure(textField: fieldId, withText: "ID#", placeholder: "ID#", tag: 2)
            configureTextField(textField: fieldId)
        }
    }
    @IBOutlet weak var fieldHectare: SkyFloatingLabelTextField! {
        didSet {
            fieldHectare.accessibilityIdentifier = "fieldHectare"
            GlobalFunctions.configure(textField: fieldHectare, withText: "Гектары(га)", placeholder: "Гектары(га)", tag: 2)
            configureTextField(textField: fieldHectare)
        }
    }
    @IBOutlet weak var averageYield: SkyFloatingLabelTextField! {
        didSet {
            averageYield.accessibilityIdentifier = "averageYield"
            GlobalFunctions.configure(textField: averageYield, withText: "Средняя урожайность(т)", placeholder: "Средняя урожайность(т)", tag: 2)
            configureTextField(textField: averageYield)
        }
    }
    @IBOutlet weak var fieldYear: SkyFloatingLabelTextField! {
        didSet {
            fieldYear.accessibilityIdentifier = "fieldYear"
            GlobalFunctions.configure(textField: fieldYear, withText: "Год", placeholder: "Год", tag: 2)
            configureTextField(textField: fieldYear)
        }
    }
    
    let resetButton = UIButton()
    var map: GMSMapView!
    var points: [MapCoordinate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGoogleMap()
        //view.addSubview(tabBarView)
        addResetButton()
        addSaveButton()
    }
    
    @IBAction func saveFiledBtn(_ sender: Any) {
        
        if (fieldHectare.text == "" || averageYield.text == "" || fieldYear.text == "") {
            showErrorAlert(message: "Добавите данные")
            
        } else {
            var coordinates = [Coordinate]()
            for coordinate in points {
                let c = Coordinate(latitude: "\(coordinate.coordinate.latitude)", longitude: "\(coordinate.coordinate.longitude)", number: coordinate.number)
                coordinates.append(c)
            }
            let field = FieldToAdd(field_id: fieldId.text!, year: Int((fieldYear.text as! NSString).intValue), hectares: (fieldHectare.text! as NSString).doubleValue, coordinates: coordinates, average_harvest: (averageYield.text! as NSString).doubleValue)
            SVProgressHUD.show()
            ServerManager.shared.addField(field: field, fieldAdded, error: showErrorAlert)
           
        }
    }
    
    @IBAction func hideMapView(_ sender: UIButton) {
        //self.dismissMapView()
        dismissMapView()
    }
    
    func fieldAdded(message: String){
        SVProgressHUD.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    func addGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 42.81064, longitude: 74.627359, zoom: 15)
        map = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        map.delegate = self
        map.mapType = .hybrid
        map.settings.myLocationButton = true
        map.padding = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
        map.isMyLocationEnabled = true
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(map)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = UIImage(named: "marker")
        marker.map = map
        setPoint(coordinate)
    }
    
    func setPoint(_ coordinate: CLLocationCoordinate2D) {
        let coord = MapCoordinate(coordinate: coordinate, number: self.points.count)
        points.append(coord)
        addLines()
    }
    
    func addLines() {
        let path = GMSMutablePath()
        for p in points {
            path.add(p.coordinate)
        }
        let line = GMSPolyline(path: path)
        line.strokeWidth = 2.0
        line.strokeColor = .white
        line.map = map
    }
    
    func addRoute() {
        let path = GMSMutablePath()
        for p in points {
            path.add(p.coordinate)
        }
        
        let route = GMSPolygon(path: path)
        route.strokeWidth = 2.0
        route.strokeColor = .white
        route.map = map
    }
    
    func addResetButton() {
        resetButton.frame = CGRect(x: view.frame.midX - 125, y: view.frame.height - 99, width: 120, height: 30)
        resetButton.setTitle("отмена", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 2
        resetButton.backgroundColor = UIColor.init(netHex: Colors.purple)
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    func addSaveButton() {
        let saveButton = UIButton()
        saveButton.frame = CGRect(x: view.frame.midX + 5, y: view.frame.height - 99, width: 120, height: 30)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 2
        saveButton.backgroundColor = UIColor.init(netHex: Colors.purple)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        view.addSubview(saveButton)
    }
}

extension MapViewController {
    
    func resetButtonClicked() {
        points.removeAll()
        map.clear()
    }
    
    func saveButtonClicked() {
        if points.count > 2 {
            acceptFiled()
        } else {
            showErrorAlert(message: "вы должны указать минимум три точки")
        }
    }
    
    func acceptFiled() {
        let alert = UIAlertController(title: "", message: "Соединить точки и добавить данные?", preferredStyle: .alert)
        //Cancel
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (acrion) in
        }))
        //Add
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (action) in
            self.addRoute()
            self.showMapView()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showMapView() {
        if isMapViewAdded {
            mapView.isHidden = false
        }
        else {
            isMapViewAdded = true
            self.view.addSubview(mapView)
        }
        mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
        mapView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.mapView.alpha = 1
            self.mapView.center = self.view.center
        }
    }
    
    func dismissMapView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height)
            self.mapView.alpha = 0
        }) { (success) in
            self.mapView.isHidden = true
        }
    }
    
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
    }
}
