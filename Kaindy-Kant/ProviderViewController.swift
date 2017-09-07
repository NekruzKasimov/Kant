//
//  ProviderViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
}

extension ProviderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTableViewCell", for: indexPath) as! ProviderTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
