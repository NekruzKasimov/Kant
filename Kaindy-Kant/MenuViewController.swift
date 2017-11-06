//
//  MenuViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

class MenuViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
            avatarImageView.clipsToBounds = true
        }
    }
    
    var menu = ["Главная", "Мои поля", "Новости" , "Услуги" , "Поставщики" , "Рассчитать бюджет", "О приложении" ,  "Выход"]
    var navigations = ["MainNav" , "FieldsNav", "NewsNav" , "ServiceNav" , "ProviderNav" , "CalcNav", "AboutAppNav" , "LoginNav"]
    var sbs = ["Main" , "Profile", "News" , "Service" , "Provider" , "CalculatorExcelViewController", "AboutApp" ,  "Login"]

    @IBAction func openProfilePage(_ sender: Any) {
        openPage(storyboard: "Profile", vcIdentifier: "ProfileNav")
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        var user = DataManager.shared.getUserInformation()
        self.nameLabel.text = "\(user!["first_name"]!) \(user!["last_name"]!)"
        SVProgressHUD.dismiss()
        if user!["photo"] == "" {
            avatarImageView.image = UIImage(named: "camera")
        } else {
            let imageToDecode = user!["photo"]
            let image = imageToDecode?.decode64(imageData: imageToDecode!)
            avatarImageView.image = image
        }
    }
    @IBOutlet weak var tablevView: UITableView!
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = menu[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openPage(storyboard: sbs[indexPath.row], vcIdentifier: navigations[indexPath.row])
    }
}

// MARK: Helper functions

extension MenuViewController {
    
    func configureTableView() {
        tablevView.tableFooterView              = UIView()
        tablevView.estimatedRowHeight           = 60
        tablevView.rowHeight                    = UITableViewAutomaticDimension
    }
    func openPage(storyboard: String, vcIdentifier: String) {
        let revealVC = revealViewController()
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
        revealVC?.pushFrontViewController(vc, animated: true)
    }
}
