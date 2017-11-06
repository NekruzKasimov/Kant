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
    
    
    @IBOutlet weak var avatarButton: UIButton! {
        didSet {
            avatarButton.layer.cornerRadius = avatarButton.frame.size.width/2
            avatarButton.clipsToBounds = true
        }
    }
    
    var menu = ["Главная", "Мои поля", "Новости" , "Услуги" , "Поставщики" , "Рассчитать бюджет", "О приложении" ,  "Выход"]
    var navigations = ["MainNav" , "FieldsNav", "NewsNav" , "ServiceNav" , "ProviderNav" , "CalcNav", "AboutAppNav" , "LoginNav"]
    var sbs = ["Main" , "Profile", "News" , "Service" , "Provider" , "CalculatorExcelViewController", "AboutApp" ,  "Login"]

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        var user = DataManager.shared.getUserInformation()
        self.nameLabel.text = "\(user!["first_name"]!) \(user!["last_name"]!)"
        SVProgressHUD.dismiss()
//        if user!["photo"] == "" {
//            avatarButton.imageView?.image = UIImage(named: "camera")
//        } else {
//            let imageToDecode = user!["photo"] as! String
//            let image = imageToDecode.decode64(imageData: imageToDecode) as! UIImage
//            avatarButton.imageView?.image = image
//        }
    }
    @IBOutlet weak var tablevView: UITableView!
    
    @IBAction func showProfilePage(_ sender: UIButton) {
        openPage(storyboard: "Profile", vcIdentifier: "ProfileNav")
    }
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
