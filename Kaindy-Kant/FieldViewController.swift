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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    
    var years = Years().years
    var yearIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мои поля"
        setNavigationBar()
        configureTableView()
        segmentedControl.selectedSegmentIndex = 0
        //self.years = DataManager.shared.getYears()
        // Do any additional setup after loading the view.
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
        ServerManager.shared.getFields(setFields, error: showErrorAlert)
    }
    @IBAction func addFiledPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.show(vc, sender: self)
        //present(vc, animated: true, completion: nil)
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
        navigationController?.show(vc, sender: self)
    }
}

