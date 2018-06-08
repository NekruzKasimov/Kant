//
//  MenuViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HideKeyboard : class {
    func stopEditing()
}

class MenuViewController: ViewController {
    
    static var hideKeyboardDelegate: HideKeyboard?
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
            avatarImageView.clipsToBounds = true
        }
    }
    var menu = Constants.MenuPage.menu
    var navigations = Constants.MenuPage.navigations
    var sbs = Constants.MenuPage.storyboards

    @IBAction func openProfilePage(_ sender: Any) {
       // self.tablevView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))?.selectionStyle = .none
        if let user_info = DataManager.shared.getUserInformation() {
            openPage(storyboard: "Profile", vcIdentifier: "ProfileNav")
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MenuViewController.hideKeyboardDelegate?.stopEditing()
        var user = DataManager.shared.getUserInformation()
        if user != nil {
        self.nameLabel.text = "\(user!["first_name"]!) \(user!["last_name"]!)"
            SVProgressHUD.dismiss()
            if user!["photo"] == "" {
                avatarImageView.image = UIImage(named: "camera")
            } else {
                let imageToDecode = user!["photo"]
                let image = imageToDecode?.decode64(imageData: imageToDecode!)
                avatarImageView.image = image
            }
        }
    }
    @IBOutlet weak var tablevView: UITableView!
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //cell.selectionStyle = .default
        cell.textLabel?.text = menu[indexPath.row].localized(lang: self.lang)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
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
        
        if storyboard == "Login" {
                let alert = UIAlertController(title: "", message: "logout_confirmation".localized(lang: self.lang)!, preferredStyle: .alert)
                //Cancel
                alert.addAction(UIAlertAction(title: Constants.Values.cancel, style: .cancel, handler: { (acrion) in
                }))
                //Add
                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action) in
                    ServerManager.shared.clearCache()
                    let revealVC = self.revealViewController()
                    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
                    revealVC?.pushFrontViewController(vc, animated: true)
                }))
                present(alert, animated: true, completion: nil)
        }
//        else if storyboard == "Profile" {
//            let revealVC = revealViewController()
//            let storyboard = UIStoryboard(name: storyboard, bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
//            revealVC?.pushFrontViewController(vc, animated: true)
//        }
        else {
            let revealVC = revealViewController()
            let storyboard = UIStoryboard(name: storyboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
            revealVC?.pushFrontViewController(vc, animated: true)
        }
    }
}
