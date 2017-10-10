//
//  LoginViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SwiftyJSON
class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
            ServerManager.shared.login(login: login!, password: password!, completion: log_in, error: showErrorAlert)
        }
        else {
            showErrorAlert(message: "Заполните поля!")
        }
        
        
    }
    func log_in(user_id: Int) {
        DataManager.shared.setUserId(user_id: user_id)
        DataManager.shared.saveUser(username: loginTextField.text!, password: passwordTextField.text!)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        present(vc, animated: true, completion: nil)
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
