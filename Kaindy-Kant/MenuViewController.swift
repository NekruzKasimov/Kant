//
//  MenuViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var menu = ["Главная", "Профиль", "Услуги" , "Поставщики" , "Заявки" , "Технология че-то че-то" , "Выход"]
    var navigations = ["MainNav" , "ProfileNav", "ServiceNav" , "ProviderNav" , "RequestNav" , "" , "LoginNav"]
    var sbs = ["Main" , "Profile", "Service", "Provider" , "Request" , "" , "Login"]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        let revealVC = revealViewController()
        let sb = UIStoryboard(name: sbs[indexPath.row], bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: navigations[indexPath.row])
        revealVC?.pushFrontViewController(vc, animated: true)
    }
}
