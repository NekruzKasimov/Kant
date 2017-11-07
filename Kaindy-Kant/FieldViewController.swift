//
//  FieldViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/4/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
import SVProgressHUD
import SkyFloatingLabelTextField
class FieldViewController: UIViewController {

    @IBOutlet weak var viewForYearPicker: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
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
    var yearsPicker = [Int]()
    var choseYear: Int = 0
    var years = Years().years
    var yearIndex = 0
    var field_id = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мои поля"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addTapped))

        self.yearsPicker = DataManager.shared.getYears()
        choseYear = yearsPicker[yearsPicker.count - 1]
        //yearPickerView.reloadAllComponents()
        
        
        setNavigationBar()
        configureTableView()
        segmentedControl.selectedSegmentIndex = 0
        yearPickerView.selectRow(yearsPicker.count - 1, inComponent: 0, animated: false)
        //self.years = DataManager.shared.getYears()
        // Do any additional setup after loading the view.
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
//        viewForYearPicker.center = CGPoint(x: self.view.bounds.size.width / 2, y: 0)
//        viewForYearPicker.alpha = 1
//        hideButton.alpha = 0.5
//        UIView.animate(withDuration: 0.3) {
//            self.hideButton.alpha = 0
//            self.viewForYearPicker.alpha = 0
//            self.viewForYearPicker.center = self.view.center
//        }
        print("pressedMe")
    }
    @IBAction func saveFiledBtn(_ sender: Any) {
        
        if (fieldHectare.text == "" || averageYield.text == "") {
            showErrorAlert(message: "Добавите данные")
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
        //removeall
        
        //reload
        setFields(years: years)
    }
    func setFields(years: Years){

        
        SVProgressHUD.dismiss()
        segmentedControl.segmentStyle = .textOnly
        var goToFirst = false
        if self.years.count == 0 {
            for (index, year) in years.years.enumerated() {
                segmentedControl.insertSegment(withTitle: "\(year.year)", at: index)
            }
        }
        else {
            for (index, year) in years.years.enumerated() {
                var isAppeared = false
                for yearOld in self.years {
                    if yearOld.year == year.year {
                        isAppeared = true
                    }
                }
                if !isAppeared {
                    segmentedControl.insertSegment(withTitle: "\(year.year)", at: index)
                    break
                }
            }
            for (index, yearOld) in self.years.enumerated() {
                var isAppeared = false
                for year in years.years {
                    if yearOld.year == year.year {
                        isAppeared = true
                    }
                }
                if !isAppeared {
                    goToFirst = true
                    segmentedControl.removeSegment(at: index)
                    break
                }
            }

        }
        if goToFirst {
            segmentedControl.selectedSegmentIndex = 0
        }
        else {
            segmentedControl.selectedSegmentIndex = yearIndex
        }
        self.years = years.years
        segmentedControl.underlineSelected = true
        segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        // change some colors
        segmentedControl.segmentContentColor = UIColor.black
        segmentedControl.selectedSegmentContentColor = UIColor.black
        segmentedControl.backgroundColor = UIColor.white
        tableView.reloadData()

    }
    func configureTableView() {
        tableView.register(UINib(nibName: "ProfileMapTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileMapTableViewCell")
        tableView.tableFooterView           = UIView()
        //tableView.separatorStyle            = .none
    }
    func segmentSelected(sender:ScrollableSegmentedControl) {
        //segmentedControl
        yearIndex = sender.selectedSegmentIndex
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
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
        //animateYearView()
        
//        let sb = UIStoryboard(name: "Profile", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        self.navigationController?.show(vc, sender: self)
        //present(vc, animated: true, completion: nil)
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
        cell.idLabel.text = self.years[yearIndex].fields[indexPath.row].field_id
        cell.areaLabel.text = "\(self.years[yearIndex].fields[indexPath.row].hectares)"
        cell.averageLabel.text = "\(self.years[yearIndex].fields[indexPath.row].average_harvest)"

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
        let alert = UIAlertController(title: "", message: "Вы действительно хотите удалить данной поле?", preferredStyle: .alert)
        //Cancel
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (acrion) in
        }))
        //Add
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (action) in
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
extension FieldViewController {
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
    }
}
