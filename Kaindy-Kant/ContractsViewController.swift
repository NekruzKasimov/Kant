//
//  ContractsViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/20/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ContractsViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    let titles = ["ДОГОВОР на приемку корнеплодов сахарной свеклы урожая 2017 года", "ДОГОВОР на переработку и приемку корнеплодов сахарной свеклы урожая 2017 года"]
    let controllers = ["KantViewController", "SugarViewController"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "contracts".localized(lang: self.lang)!
    }
    
}
extension ContractsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractsTableViewCell", for: indexPath) as! ContractsTableViewCell
        cell.title.text = titles[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Contracts", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: controllers[indexPath.row])
        self.navigationController?.show(vc, sender: self)
    }
}
