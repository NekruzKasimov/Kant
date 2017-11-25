//
//  TechnologiesListViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/20/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

class TechnologiesListViewController: ViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var technologies = ["technology", "calendar"]
    var technologies_title = ["Технология возведения свеклы", "Календарь свекловода"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SVProgressHUD.show()
//        ServerManager.shared.getTechnologies(setTechnologies) { (error) in
//            SVProgressHUD.dismiss()
//            self.showErrorAlert(message: error)
//        }
        self.navigationController?.navigationBar.topItem?.title = ""
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "technology".localized(lang: self.lang)!
    }
    
//    func setTechnologies(technologies: Technologies) {
//        self.technologies = technologies
//        tableView.reloadData()
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return technologies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TechnologyTableViewCell")
        cell?.textLabel?.text = technologies_title[indexPath.row]
        //cell?.textLabel?.text = technologies[indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TechnologiesViewController") as! TechnologiesViewController
        vc.pdfName = self.technologies[indexPath.row]
        navigationController?.show(vc, sender: self)
    }
}
