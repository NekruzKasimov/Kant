//
//  ContactsViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var contacts: Contacts!
    
    var titles = [["phone", "Телефон"], ["fax", "Факс"], ["social", "Социальная сеть"], ["web", "Сайт"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
}

//MARK: UITableViewDataSourse methods

extension ContactsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contacts?.array.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        var title = ""
        
        for item in titles {
            if item[0] == contacts?.array[indexPath.row].type {
                title = item[1]
            }
        }
        cell.titleLabel.text = title
        cell.dataLabel.text = contacts?.array[indexPath.row].data
        return cell
    }
}


//MARK: UITableViewDelegate methods

extension ContactsViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContactsTableViewCell
        if cell.titleLabel.text == "Телефон" {
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                self.call(data: cell.dataLabel.text!)
//            })
//            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
//            Alert.shared.showCustomAlertIn(vc: self, withTitle: "Телефон", message: "Вы хотите позвонить по номеру \(cell.dataLabel.text!)", actions: [okAction, cancelAction])
            self.call(data: cell.dataLabel.text!)
        } else if cell.titleLabel.text == "Сайт" {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.browser(data: cell.dataLabel.text!)
            })
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            Alert.shared.showCustomAlertIn(vc: self, withTitle: "Браузер", message: "Вы хотите открыть сайт \(cell.dataLabel.text!)", actions: [okAction, cancelAction])
        }
        
    }
}


//MARK: Helper functions

extension ContactsViewController {
    func configureTableView() {
        tableView.estimatedRowHeight            = 80
        tableView.rowHeight                     = UITableViewAutomaticDimension
        tableView.tableFooterView               = UIView()
    }
    
    func call(data: String) {
        let temp = returnNumber(number: data)
        if let url = NSURL(string: "telprompt:\(temp)"){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                
            }
        }
    }
    
    func browser(data: String){
        if data.contains("http") {
            UIApplication.shared.openURL(URL(string: data)!)
        } else {
            UIApplication.shared.openURL(URL(string: "http://" + data)!)
        }
    }
    
    func returnNumber(number: String) -> String {
        var ans = [Character]()
        for char in number.characters {
            if ((String(char).rangeOfCharacter(from: CharacterSet.alphanumerics.inverted)) == nil) {
                ans.append(char)
            }
        }
        return String(ans)
    }
}

//MARK: SJSegmentViewController

extension ContactsViewController: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return tableView
    }
}

