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
    let titles = [" Договор ОАО \"Каинды-Кант\" 50% деньги / 50% сахар", "Договор ОАО \"Каинды-Кант\" на 100%сахар", "Договор ОАО \"Кошой\" 50% сахар / 50% деньги", "Договор ОАО \"Кошой\" на 100%сахар"]
    let controllers = ["KantViewController", "SugarViewController", "Contract2ViewController", "Contract4ViewController"]
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
        return 4
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
