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
            GlobalFunctions.configure(textField: loginTextField, withText: "Логин", placeholder: "(XXX) YY-YY-YY", tag: 0)
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
    var phoneNumber = "0("

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        ServerManager.shared.registerFirebaseToken(parameters: ["firebase_token" : ""], {
            DataManager.shared.clearData()
        }) { (error) in
            print(error)
        }
        self.title = "Авторизация"
    }
    @IBOutlet weak var registrationButton: UIButton! {
        didSet {
            registrationButton.accessibilityIdentifier = "registrationButton"
            let attributes: [String : Any] = [
                NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20),
                NSForegroundColorAttributeName: UIColor.darkGray
            ]
            let attributeString = NSMutableAttributedString(string: "Регистрация", attributes: attributes)
            registrationButton.setAttributedTitle(attributeString, for: .normal)
            registrationButton.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        var login = loginTextField.text?.westernArabicNumeralsOnly
        login?.remove(at: (login?.startIndex)!)
        let password = passwordTextField.text
        if login != "" && password != "" {
            //HUD.show(.progress)
            ServerManager.shared.login(login: login!, password: password!, completion: log_in, error: showErrorAlert)
        }
        else {
            let alertController = UIAlertController(title: "Ошибка", message: "Заполните поля!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func log_in(user_id: Int) {
        //HUD.hide()
        DataManager.shared.setUserId(user_id: user_id)
        DataManager.shared.saveUser(username: (loginTextField.text?.westernArabicNumeralsOnly)!, password: passwordTextField.text!)
        UIApplication.shared.registerForRemoteNotifications()
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
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        let totalString = "\(loginTextField.text!)\(string)"
//        if !self.isValid(number: totalString, in: range) {
//            return false
//        }
        
        if(loginTextField.tag == 0) {
            if (range.location == 0 && string == "0") { return false }
            if (range.length == 1) {
                if phoneNumber != "0" {
                    let end = phoneNumber.index(phoneNumber.endIndex, offsetBy: -1)
                    phoneNumber = phoneNumber.substring(to: end)
                }
               
                loginTextField.text = PhoneNumbers.format(input: totalString, true)
            } else {
                if phoneNumber.count < 10 {
                    phoneNumber += string
                }
                loginTextField.text = PhoneNumbers.format(input: totalString, false)
            }
            print("my phone - \(phoneNumber)")
            return false
        }
        
        return true
    }
}

