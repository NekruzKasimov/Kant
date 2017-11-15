//
//  LoginViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SwiftyJSON
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: SkyFloatingLabelTextField! {
        didSet {
            loginTextField.accessibilityIdentifier = "loginTextField"
            GlobalFunctions.configure(textField: loginTextField, withText: "Логин", placeholder: "Логин", tag: 0)
            loginTextField.keyboardType = .phonePad
            configureTextField(textField: loginTextField)
            
        }
    }
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField! {
        didSet {
            passwordTextField.accessibilityIdentifier = "passwordTextField"
            GlobalFunctions.configure(textField: passwordTextField, withText: "Пароль", placeholder: "Пароль", tag: 1)
            configureTextField(textField: passwordTextField)
            passwordTextField.isSecureTextEntry = true
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
        DataManager.shared.clearData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBOutlet weak var registrationButton: UIButton! {
        didSet {
            registrationButton.accessibilityIdentifier = "registrationButton"
            let attributes: [String : Any] = [
                NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20),
                NSForegroundColorAttributeName: UIColor(red: 157/255, green: 32/255, blue: 70/255)
            ]
            let attributeString = NSMutableAttributedString(string: "Регистрация", attributes: attributes)
            registrationButton.setAttributedTitle(attributeString, for: .normal)
            registrationButton.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let login = loginTextField.text
        let password = passwordTextField.text
        if login != "" && password != "" {
            //HUD.show(.progress)
            ServerManager.shared.login(login: login!, password: password!, completion: log_in, error: showErrorAlert)
        }
        else {
            showErrorAlert(message: "Заполните поля!")
        }
        
        
    }
    
    func log_in(user_id: Int) {
        //HUD.hide()
        DataManager.shared.setUserId(user_id: user_id)
        DataManager.shared.saveUser(username: loginTextField.text!, password: passwordTextField.text!)
        let sb = UIStoryboard(name: "Registration", bundle: nil)
        let nextViewController = sb.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
        self.present(nextViewController!, animated:true, completion:nil)
    }
}

extension LoginViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            textField.resignFirstResponder()
        }
      return true
    }
    
    func showRegister() {
        let sb = UIStoryboard(name: "Registration", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
