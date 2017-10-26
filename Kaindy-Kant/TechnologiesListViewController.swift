//
//  TechnologiesListViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/20/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

class TechnologiesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var technologies: Technologies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        ServerManager.shared.getTechnologies(setTechnologies) { (error) in
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        }
        self.navigationController?.navigationBar.topItem?.title = ""
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Технологии"
    }
    
    func setTechnologies(technologies: Technologies) {
        self.technologies = technologies
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let counter = technologies?.array.count {
            SVProgressHUD.dismiss()
            return counter
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = technologies?.array[indexPath.row].name
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TechnologiesViewController") as! TechnologiesViewController
        vc.desc = technologies?.array[indexPath.row].text
        vc.title = technologies?.array[indexPath.row].name
        navigationController?.show(vc, sender: self)
    }
}
