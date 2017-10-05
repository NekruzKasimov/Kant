//
//  ContactsOfResourceProtectionViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ContactOfResourceProtectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ContactOfResourceProtectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hassanza"
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let sb = UIStoryboard(name: "DetailProvider", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "DetailContactOfResourceProtectionViewController") as! DetailContactOfResourceProtectionViewController
            navigationController?.pushViewController(vc, animated: true)
        }
}
