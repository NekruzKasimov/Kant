//
//  MenuViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var menu = ["Главная", "Услуги" , "Поставщики" , "Заявки" , "Технология че-то че-то" , "Выход"]
    var navigations = ["MainNav" , "ServiceNav" , "ProviderNav" , "RequestNav" , "" , "LoginNav"]
    var sbs = ["Main" , "Service", "Provider" , "Request" , "" , "Login"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func showProfilePage(_ sender: UIButton) {
        openPage(storyboard: "Profile", vcIdentifier: "ProfileNav")
    }
    
    func openPage(storyboard: String, vcIdentifier: String) {
        let revealVC = revealViewController()
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
        revealVC?.pushFrontViewController(vc, animated: true)
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
