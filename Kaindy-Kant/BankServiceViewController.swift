//
//  BankServiceViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 19.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class BankServiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension BankServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Айыл Банк"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailedService", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailedBankViewController") as! DetailedBankViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
