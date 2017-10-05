//
//  MenuViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var menu = ["Главная", "Новости" , "Услуги" , "Поставщики" , "Заявки" , "Технология возведения свеклы" , "О приложении" , "Выход", "Excel"]
    var navigations = ["MainNav" , "NewsNav" , "ServiceNav" , "ProviderNav" , "RequestNav" , "TechnologyInfoNav" , "AboutAppNav" , "LoginNav", "CalcNav"]
    var sbs = ["Main" ,  "News" , "Service" , "Provider" , "Request" , "TechnologyInfo" , "AboutApp" , "Login", "CalculatorExcelViewController"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
