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


class MapViewController: UIViewController, GMSMapViewDelegate {
    
    struct MapCoordinate {
        var coordinate: CLLocationCoordinate2D
        var number: Int
    }

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var fieldHectare: UITextField!
    @IBOutlet weak var averageYield: UITextField!
    @IBOutlet weak var allYield: UITextField!
    
    var map: GMSMapView!
    var points: [MapCoordinate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Карта"
        addGoogleMap()
        addResetButton()
        addSaveButton()
    }
    
    @IBAction func saveFiledBtn(_ sender: Any) {
        
        if (fieldHectare.text == "" || averageYield.text == "" || allYield.text == "") {
            showErrorAlert(message: "Добавите данные")
            
        } else {
            var coordinates = [Coordinate]()
            for coordinate in points {
                let c = Coordinate(latitude: "\(coordinate.coordinate.latitude)", longitude: "\(coordinate.coordinate.longitude)", number: coordinate.number)
                coordinates.append(c)
            }
            let field = FieldToAdd(field_id: "9000", year: 2017, hectares: (fieldHectare.text! as NSString).doubleValue, coordinates: coordinates)
            SVProgressHUD.show()
            ServerManager.shared.addField(field: field, fieldAdded, error: showErrorAlert)
           
        }
    }
    func fieldAdded(message: String){
        SVProgressHUD.dismiss()
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 42.81064, longitude: 74.627359, zoom: 15)
        map = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        map.delegate = self
        map.mapType = .hybrid
        map.settings.myLocationButton = true
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
        route.strokeColor = UIColor.green
        route.map = map
    }
    
    func addResetButton() {
        let resetButton = UIButton()
        resetButton.frame = CGRect(x: 10, y: view.frame.height - 50, width: 100, height: 40)
        resetButton.setTitle("Отменить", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 5
        resetButton.backgroundColor = UIColor.init(netHex: Colors.purple)
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    func addSaveButton() {
        let saveButton = UIButton()
        saveButton.frame = CGRect(x: 120, y: view.frame.height - 50, width: 100, height: 40)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.backgroundColor = UIColor.init(netHex: Colors.green)
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
            self.animateIn()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func animateIn() {
        self.view.addSubview(mapView)
        
        mapView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        mapView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.mapView.alpha = 1
            self.mapView.transform = CGAffineTransform.identity
        }
    }
}
