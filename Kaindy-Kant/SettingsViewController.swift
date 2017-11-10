//
//  SettingsViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/10/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let options = Constants.SettingsOptions.options
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Настройки"
        // Do any additional setup after loading the view.
    }
    

}
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.settingsLabel.text = self.options[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "Registration", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
            self.navigationController?.show(vc!, sender: self)
        }
        else if indexPath.row == 1{
            let sb = UIStoryboard(name: "AboutApp", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "AboutAppViewController") as? AboutAppViewController
            self.navigationController?.show(vc!, sender: self)
        }
    }
}
