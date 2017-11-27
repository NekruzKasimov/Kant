//
//  ChangePasswordViewController.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SVProgressHUD
class ChangePasswordViewController: ViewController {
    @IBOutlet weak var changeButton: UIButton! {
        didSet {
            changeButton.setTitle("change".localized(lang: self.lang)!, for: .normal)
        }
    }
    @IBOutlet weak var old_password: SkyFloatingLabelTextField! {
        didSet {
            old_password.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: old_password, withText: "current_password".localized(lang: self.lang)!, placeholder: "current_password".localized(lang: self.lang)!, tag: 0)
            configureTextField(textField: old_password)
        }
    }
    
    @IBOutlet weak var new_password: SkyFloatingLabelTextField! {
        didSet {
            new_password.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: new_password, withText: "new_password".localized(lang: self.lang)!, placeholder: "new_password".localized(lang: self.lang)! , tag: 1)
            configureTextField(textField: new_password)
        }
    }
    @IBOutlet weak var new_password_repeat: SkyFloatingLabelTextField! {
        didSet {
            new_password_repeat.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: new_password_repeat, withText: "rep_new_password".localized(lang: self.lang)! , placeholder: "rep_new_password".localized(lang: self.lang)! , tag: 2)
            configureTextField(textField: new_password_repeat)
        }
    }
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePressed(_ sender: Any) {
        print("pressed")
        SVProgressHUD.show()
        let change = ChangePassword(old_password: old_password.text!, new_password: new_password.text!, new_password_repeat: new_password_repeat.text!)
        ServerManager.shared.updatePassword(changePassword: change, changePassword, error: showErrorAlert)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "change_password".localized(lang: self.lang)!
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    func changePassword(){
        SVProgressHUD.dismiss()
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.present(vc, animated: false, completion: nil)
    }

}
