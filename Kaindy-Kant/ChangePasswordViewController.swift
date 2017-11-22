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
class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var old_password: SkyFloatingLabelTextField! {
        didSet {
            old_password.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: old_password, withText: "Введите старый пароль", placeholder: "Введите старый пароль", tag: 0)
            configureTextField(textField: old_password)
        }
    }
    
    @IBOutlet weak var new_password: SkyFloatingLabelTextField! {
        didSet {
            new_password.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: new_password, withText: "Введите новый пароль", placeholder: "Введите новый пароль" , tag: 1)
            configureTextField(textField: new_password)
        }
    }
    @IBOutlet weak var new_password_repeat: SkyFloatingLabelTextField! {
        didSet {
            new_password_repeat.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: new_password_repeat, withText: "Повторите новый пароль" , placeholder: "Повторите новый пароль" , tag: 2)
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
        self.title = "Изменить пароль"
    }
    func changePassword(){
        SVProgressHUD.dismiss()
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.present(vc, animated: false, completion: nil)
    }

}
