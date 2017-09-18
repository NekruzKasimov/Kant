//
//  ProviderViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController {
    
    var providers = [["Поставщики средств защиты", "fertilizer"] , ["Поставщики удобрений", "remedies"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
}

extension ProviderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTableViewCell", for: indexPath) as! ProviderTableViewCell
        cell.providerLbl.text = providers[indexPath.row][0]
        cell.providerImg.image = UIImage(named: providers[indexPath.row][1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
