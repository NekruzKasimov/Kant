//
//  FieldViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/4/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
class FieldViewController: UIViewController {

    @IBOutlet weak var viewForYearPicker: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var hideButton: UIButton!
    
    var yearsPicker = [Int]()
    var choseYear: Int = 0
    var years = Years().years
    var yearIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мои поля"
        self.yearsPicker = DataManager.shared.getYears()
        choseYear = yearsPicker[yearsPicker.count - 1]
        setNavigationBar()
        configureTableView()
        segmentedControl.selectedSegmentIndex = 0
        //self.years = DataManager.shared.getYears()
        // Do any additional setup after loading the view.
    }
    @IBAction func hideButtonPressed(_ sender: Any) {
        self.viewForYearPicker.isHidden = true
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
    func setFields(years: Years){
        segmentedControl.segmentStyle = .textOnly
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
                }
            }
       
        }
        self.years = years.years
        segmentedControl.selectedSegmentIndex = yearIndex
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 270
    //    }
    func didPressButton(_ tag: Int) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailedMapViewController") as! DetailedMapViewController
        vc.coordinates = self.years[yearIndex].fields[tag].coordinates
        vc.field_id = self.years[yearIndex].fields[tag].id
        navigationController?.show(vc, sender: self)
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


