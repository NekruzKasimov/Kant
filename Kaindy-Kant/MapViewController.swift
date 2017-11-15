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

class MapViewController: ViewController, GMSMapViewDelegate, CLLocationManagerDelegate{
    
    struct MapCoordinate {
        var coordinate: CLLocationCoordinate2D
        var number: Int
    }

    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var mapView: UIView!
    var isMapViewAdded = false
    var fieldsToShow = [Field]()
    var bounds = GMSCoordinateBounds()
    var yearChose = 0
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
            GlobalFunctions.configure(textField: fieldHectare, withText: "hectar".localized(lang: self.lang)!, placeholder: "hectar".localized(lang: self.lang)!, tag: 2)
            configureTextField(textField: fieldHectare)
        }
    }
    @IBOutlet weak var averageYield: SkyFloatingLabelTextField! {
        didSet {
            averageYield.accessibilityIdentifier = "averageYield"
            GlobalFunctions.configure(textField: averageYield, withText: "average_yield".localized(lang: self.lang)!, placeholder: "average_yield".localized(lang: self.lang)!, tag: 2)
            configureTextField(textField: averageYield)
        }
    }
    @IBOutlet weak var beet_point_name: SkyFloatingLabelTextField! {
        didSet {
            beet_point_name.accessibilityIdentifier = "beet_point_name"
            GlobalFunctions.configure(textField: beet_point_name, withText: "Свеклоприкмный пукт" , placeholder: "Свеклоприкмный пукт", tag: 2)
            configureTextField(textField: beet_point_name)
        }
    }
    
    let resetButton = UIButton()
    let saveButton = UIButton()
    let addInfoButton = UIButton()

   // var map: GMSMapView!
    var points: [MapCoordinate] = []
    var locationManager = CLLocationManager()
    var beetPoints = [BeetPoint]()
    var beetPointIndex = 0
    lazy var map = GMSMapView()

    @IBOutlet weak var hideButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Карта"
        if !UserDefaults.standard.bool(forKey: "isTipShown") {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        setBeetPointsInformation()
        addGoogleMap()
        //addCurrentLocation()
        //view.addSubview(tabBarView)
        addResetButton()
        addAddInfoButton()
        addSaveButton()
    }
    func setBeetPointsInformation(){
        if let beetPoints = DataManager.shared.getBeetPoints() {
            self.beetPoints = beetPoints
            self.beet_point_name.text = beetPoints[0].name
        } else {
            ServerManager.shared.getBeetPoints(setBeetPoints, error: showErrorAlert)
        }
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        beet_point_name.inputView = pickerView
    }
    func setBeetPoints(beetPoints: BeetPoints) {
        self.beetPoints = beetPoints.array
        self.beet_point_name.text = beetPoints.array[0].name
        
    }
    @IBAction func hideButtonPressed(_ sender: Any) {
        dismissMapView()
    }
    @IBAction func saveFiledBtn(_ sender: Any) {
        
        if (fieldHectare.text == "" || averageYield.text == "") {
            showErrorAlert(message: "fill_field".localized(lang: self.lang)!)
        } else {
            let coordinates = Coordinates()
            for coordinate in points {
                let c = Coordinate(latitude: "\(coordinate.coordinate.latitude)", longitude: "\(coordinate.coordinate.longitude)", number: coordinate.number)
                coordinates.array.append(c)
            }
            let doubleString = fieldHectare.text!.replacingOccurrences(of: ",", with: ".")
           // print(fieldHectare.text,(doubleString as NSString).doubleValue, (fieldHectare.text! as NSString))
            //print(Double(doubleString))
            let field = FieldToAdd(field_id: fieldId.text!, year: yearChose, hectares: (doubleString as NSString).doubleValue, coordinates: coordinates, average_harvest: (averageYield.text! as NSString).doubleValue, point_id: self.beetPoints.count == 0 ? 0 : self.beetPoints[beetPointIndex].id)
            SVProgressHUD.show()
            ServerManager.shared.addField(field: field, fieldAdded, error: showErrorAlert)
           
        }
    }
    
    @IBAction func hideMapView(_ sender: UIButton) {
        //self.dismissMapView()
        dismissMapView()

    }
    func askForOpeningExcel(id: Int){
        let alert = UIAlertController(title: "", message: "Расчитать бюджет для данного поля?", preferredStyle: .alert)
        //Cancel
        alert.addAction(UIAlertAction(title: "Пропустить", style: .cancel, handler: { (acrion) in
            self.navigationController?.popViewController(animated: true)
        }))
        //Add
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action) in
            print("ok")
            let sb = UIStoryboard(name: "CalculatorExcelViewController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CalculatorExcelViewController") as! CalculatorExcelViewController
            vc.fieldId = id
            self.navigationController?.show(vc, sender: self)
        }))
        present(alert, animated: true, completion: nil)
        
    }
    func fieldAdded(id: Int){
        
        SVProgressHUD.dismiss()
        askForOpeningExcel(id: id)
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
        fillExistingFields()
    }
    func fillExistingFields() {
        for field in fieldsToShow {
            var googlePoints: [CLLocationCoordinate2D] = []
            for coordinate in field.coordinates.array {
                googlePoints.append(CLLocationCoordinate2D(latitude: (coordinate.latitude as NSString).doubleValue, longitude: (coordinate.longitude as NSString).doubleValue))
            }
            setupField(points: googlePoints)
        }
    }
    func setupField(points: [CLLocationCoordinate2D]) {
        let path = GMSMutablePath()
        for p in points {
            bounds = bounds.includingCoordinate(p)
            path.add(p)
            
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        map.animate(with: update)
        let line = GMSPolyline(path: path)
        let field = GMSPolygon(path: path)
        field.strokeWidth = 2.0
        field.strokeColor = UIColor.green
        field.map = map
        line.strokeWidth = 2
        line.strokeColor = .green
        line.map = map
    }
    func addCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
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
        line.strokeColor = .green
        line.map = map
    }
    
    func addRoute() {
        let path = GMSMutablePath()
        for p in points {
            path.add(p.coordinate)
        }
        let route = GMSPolygon(path: path)
        route.strokeWidth = 2.0
        route.strokeColor = .green
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
        saveButton.frame = CGRect(x: view.frame.midX + 5, y: view.frame.height - 99, width: 120, height: 30)
        saveButton.setTitle("Соеденить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 2
        saveButton.backgroundColor = UIColor.init(netHex: Colors.purple)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    func addAddInfoButton(){
        addInfoButton.frame = CGRect(x: view.frame.midX + 5, y: view.frame.height - 99, width: 120, height: 30)
        addInfoButton.setTitle("save".localized(lang: self.lang), for: .normal)
        addInfoButton.setTitleColor(.white, for: .normal)
        addInfoButton.layer.cornerRadius = 2
        addInfoButton.backgroundColor = UIColor.init(netHex: Colors.purple)
        addInfoButton.addTarget(self, action: #selector(addInfoButtonClicked), for: .touchUpInside)
        view.addSubview(addInfoButton)
    }
}
extension MapViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.beetPoints.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.beetPoints[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        beet_point_name.text = self.beetPoints[row].name
        beetPointIndex = row
        self.view.endEditing(true)
    }
}
extension MapViewController {
    
    func resetButtonClicked() {
        //self.addInfoButton.removeFromSuperview()
        //self.addSaveButton()
        self.saveButton.isHidden = false
        points.removeAll()
        map.clear()
        fillExistingFields()
    }
    
    func saveButtonClicked() {
        if points.count > 2 {
            acceptFiled()
        } else {
            showErrorAlert(message: "Вы должны указать минимум три точки")
        }
    }
    
    func acceptFiled() {
        let alert = UIAlertController(title: "", message: "Соединить точки?", preferredStyle: .alert)
        //Cancel
        alert.addAction(UIAlertAction(title: Constants.Values.cancel , style: .cancel, handler: { (acrion) in
        }))
        //Add
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (action) in
            self.addRoute()
            self.saveButton.isHidden = true
            //self.saveButton.removeFromSuperview()
            //self.addAddInfoButton()
        }))
        present(alert, animated: true, completion: nil)
    }
   
    func addInfoButtonClicked(){
        self.showMapView()
    }
    func showMapView() {
        if isMapViewAdded {
            mapView.isHidden = false
            hideButton.isHidden = false
        }
        else {
            isMapViewAdded = true
            //mapView.isHidden = false
            self.view.addSubview(hideButton)
            self.view.addSubview(mapView)
        }
        mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
        self.hideButton.backgroundColor = UIColor.black
        mapView.alpha = 0
        hideButton.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.mapView.alpha = 1
            self.hideButton.alpha = 0.5
            self.mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.frame.height / 2)
        }
    }
    
    func dismissMapView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height)
            self.mapView.alpha = 0
            self.hideButton.alpha = 0
        }) { (success) in
            self.hideButton.isHidden = true
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
