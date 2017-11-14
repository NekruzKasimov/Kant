//
//  FieldViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/4/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD
import SkyFloatingLabelTextField
import HSegmentControl
class FieldViewController: ViewController {

    @IBOutlet weak var addFieldButton: UIButton! {
        didSet {
            addFieldButton.setTitle("add_field".localized(lang: self.lang), for: .normal)
        }
    }
    @IBOutlet weak var viewForYearPicker: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: HSegmentControl!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var mapView: UIView!
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
            GlobalFunctions.configure(textField: fieldHectare, withText: "hectar".localized(lang: self.lang)! , placeholder: "hektar".localized(lang: self.lang)!, tag: 2)
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
    var yearsPicker = [Int]()
    var choseYear: Int = 0
    var years = Years().years
    var yearIndex = 0
    var field_id = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.MainPage.myFields
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add".localized(lang: self.lang)!, style: .plain, target: self, action: #selector(addTapped))
        //ServerManager.shared.ge
        
        self.yearsPicker = DataManager.shared.getYears()
        choseYear = yearsPicker[yearsPicker.count - 1]
        //yearPickerView.reloadAllComponents()
        
        setNavigationBar()
        configureTableView()
        //segmentedControl.selectedIndex = 0
        yearPickerView.selectRow(yearsPicker.count - 1, inComponent: 0, animated: false)
        segmentedControl.dataSource = self
        print(getNumberOfDisplayedSegments())
        segmentedControl.numberOfDisplayedSegments = getNumberOfDisplayedSegments()
        segmentedControl.segmentIndicatorViewContentMode = UIViewContentMode.bottom
        segmentedControl.selectedTitleFont = UIFont.boldSystemFont(ofSize: 19)
        segmentedControl.selectedTitleColor = UIColor.black
        segmentedControl.unselectedTitleFont = UIFont.systemFont(ofSize: 17)
        segmentedControl.unselectedTitleColor = UIColor.darkGray
        segmentedControl.segmentIndicatorImage = UIImage(named: "arrow_up")

    }
   
    func getNumberOfDisplayedSegments() -> Int{
        return self.years.count == 0 ? 1  : self.years.count == 1 ? 1 : self.years.count == 2 ? 2 : 3
    }
    @IBAction func hideMapView(_ sender: UIButton) {
        //self.dismissMapView()
        dismissMapView()
        
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
    func showMapView(tag: Int) {
        self.fieldId.text = "\(self.years[yearIndex].fields[tag].field_id)"
        self.fieldHectare.text = "\(self.years[yearIndex].fields[tag].hectares)"
        self.averageYield.text = "\(self.years[yearIndex].fields[tag].average_harvest)"

        self.mapView.isHidden = false
        self.hideButton.isHidden = false
        self.hideButton.backgroundColor = UIColor.black
        mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
        mapView.alpha = 0
        hideButton.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.hideButton.alpha = 0.5
            self.mapView.alpha = 1
            self.mapView.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.frame.height / 2)
        }
    }
    func addTapped(){
        self.viewForYearPicker.isHidden = false
        self.hideButton.isHidden = false
        self.hideButton.backgroundColor = UIColor.black
        viewForYearPicker.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
        viewForYearPicker.alpha = 0
        hideButton.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.hideButton.alpha = 0.5
            self.viewForYearPicker.alpha = 1
            self.viewForYearPicker.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.frame.height / 2)
        }
    }
    
    @IBAction func hideButtonPressed(_ sender: Any) {
        self.viewForYearPicker.isHidden = true
        self.mapView.isHidden = true
        self.hideButton.isHidden = true
    }
    @IBAction func saveFiledBtn(_ sender: Any) {
        
        if (fieldHectare.text == "" || averageYield.text == "") {
            showErrorAlert(message: "fill_field".localized(lang: self.lang)!)
        } else {
            let doubleString = fieldHectare.text!.replacingOccurrences(of: ",", with: ".")
            SVProgressHUD.show()
            let field_info = ["field_id": fieldId.text!, "hectares": doubleString, "average_harvest": averageYield.text!]
           ServerManager.shared.updateField(field_id: field_id, parameters: field_info, fieldUpdated, error: showErrorAlert)
        }
    }
    func fieldUpdated(message: String){
        print(message)
        ServerManager.shared.getFields(setFields, error: showErrorAlert)
        SVProgressHUD.dismiss()
        dismissMapView()
    }
    func setFiledAfterDeleting(years: Years) {
        setFields(years: years)
    }
    func setFields(years: Years){

        SVProgressHUD.dismiss()
        self.years = years.years
        if yearIndex >= self.years.count {
            yearIndex = yearIndex - 1
            if yearIndex > -1 {
                segmentedControl.selectedIndex = yearIndex
            }
        }
        if yearIndex < 0 {
            yearIndex = 0
        }
        segmentedControl.reloadData()
        segmentedControl.numberOfDisplayedSegments = getNumberOfDisplayedSegments()
        tableView.reloadData()

    }
    func configureTableView() {
        tableView.register(UINib(nibName: "ProfileMapTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileMapTableViewCell")
        tableView.tableFooterView           = UIView()
        //tableView.separatorStyle            = .none
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        yearIndex = (sender as! HSegmentControl).selectedIndex
        print("Segment at index \(yearIndex)  selected")
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewForYearPicker.isHidden = true
        self.hideButton.isHidden = true
        self.mapView.isHidden = true
        ServerManager.shared.getFields(setFields, error: showErrorAlert)
    }
    @IBAction func addFiledPressed(_ sender: Any) {
        self.viewForYearPicker.isHidden = false
        self.hideButton.isHidden = false
        self.hideButton.backgroundColor = UIColor.black
        viewForYearPicker.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
        viewForYearPicker.alpha = 0
        hideButton.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.hideButton.alpha = 0.5
            self.viewForYearPicker.alpha = 1
            self.viewForYearPicker.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.frame.height / 2)
        }
    }
    func animateYearView(){
        viewForYearPicker.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
        viewForYearPicker.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.viewForYearPicker.alpha = 1
            self.viewForYearPicker.center = self.view.center
        }
    }
    @IBAction func addFieldPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.yearChose = self.choseYear
        vc.fieldsToShow = getFieldsIfExist()
        self.navigationController?.show(vc, sender: self)
    }
    func getFieldsIfExist() -> [Field] {
        for (index, year) in years.enumerated() {
            if (year.year as NSString).intValue == choseYear {
                return years[index].fields
            }
        }
        return [Field]()
    }

}
extension FieldViewController: HSegmentControlDataSource {
    func segmentControl(_ segmentControl: HSegmentControl, titleOfIndex index: Int) -> String {
        return self.years.count == 0 ? "2017" : self.years[index].year
    }
    
    func numberOfSegments(_ segmentControl: HSegmentControl) -> Int {
        return self.years.count == 0 ? 1 : self.years.count
    }
    
}
extension FieldViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.yearsPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.yearsPicker[row])"
        }
}

extension FieldViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(yearsPicker[row])
        choseYear = yearsPicker[row]
        self.view.endEditing(true)
    }
}

extension FieldViewController: UITableViewDataSource, UITableViewDelegate, ButtonDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.years.count == 0 {
            return 0
        }
        print(self.years[yearIndex].fields.count)
        return self.years[yearIndex].fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMapTableViewCell") as! ProfileMapTableViewCell
        cell.cellDelegate = self
        cell.tag = indexPath.row
        let id = self.years[yearIndex].fields[indexPath.row].field_id
        cell.idLabel.text = id == "" ? "ID:-------------" : "ID:\(id)"
        cell.areaLabel.text = "\(self.years[yearIndex].fields[indexPath.row].hectares)"
        cell.averageLabel.text = "\(self.years[yearIndex].fields[indexPath.row].average_harvest)"
        cell.totalLabel.text = "\(Double(self.years[yearIndex].fields[indexPath.row].hectares) * Double(self.years[yearIndex].fields[indexPath.row].average_harvest))"
        cell.beetLabel.text = self.years[yearIndex].fields[indexPath.row].point_name
        

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 270
    //    }
    func didPressButton(_ tag: Int, _ action: String) {
        if action == "show" {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "DetailedMapViewController") as! DetailedMapViewController
            vc.coordinates = self.years[yearIndex].fields[tag].coordinates
            vc.field_id = self.years[yearIndex].fields[tag].id
            navigationController?.show(vc, sender: self)
        }
        else if action == "delete" {
            uvensinbi(tag: tag)
        }
        else {
            field_id = self.years[yearIndex].fields[tag].id
            showMapView(tag: tag)
        }
    }
    func uvensinbi(tag: Int) {
        let alert = UIAlertController(title: "", message: "Вы действительно хотите удалить данное поле?", preferredStyle: .alert)
        //Cancel
        alert.addAction(UIAlertAction(title: Constants.Values.cancel, style: .cancel, handler: { (acrion) in
        }))
        //Add
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action) in
            SVProgressHUD.show()
            ServerManager.shared.deleteField(field_id: self.years[self.yearIndex].fields[tag].id, self.deleteField, error: self.showErrorAlert)
        }))
        present(alert, animated: true, completion: nil)
    }
    func deleteField(message: String)  {
        ServerManager.shared.getFields(setFields, error: showErrorAlert)
        print(message)
    }
}

extension FieldViewController {
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
    }
}
