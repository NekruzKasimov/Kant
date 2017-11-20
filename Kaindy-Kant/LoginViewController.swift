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
    var phoneNumber = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
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
    func format(input: String, _ deleteLastChar: Bool) -> String {
        var str = ""
        
        if input.count == 0 {
            return str
        }
        
        var regex: NSRegularExpression?
        do {
            regex =  try NSRegularExpression(pattern: "[\\s-\\(\\)]" , options: .caseInsensitive)
            
            str = regex!.stringByReplacingMatches(in: input, options: .init(rawValue: 0), range: NSRange(location: 0, length: input.count), withTemplate: "")
            
            if str.count > 9 {
                let end = str.index(str.startIndex, offsetBy: 9)
                str = str.substring(to: end)
            }
            if deleteLastChar {
                let end = str.index(str.endIndex, offsetBy: -1)
                str = str.substring(to: end)
            }
            if str.count < 3 {
                str = str.replacingOccurrences(of: "(\\d+)", with: "($1", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 3 {
                str = str.replacingOccurrences(of: "(\\d{3})", with: "($1) ", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 4 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 5 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2-", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 6 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 7 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d+)", with: "($1) $2-$3-", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else if str.count == 8 {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d{2})(\\d+)", with: "($1) $2-$3-$4", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            else {
                str = str.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d{2})(\\d{2})", with: "($1) $2-$3-$4", options: .regularExpression, range:  str.startIndex..<str.endIndex)
            }
            print("str = \(str)")
            return str
            
        }
        catch _  {
            print("error in formatting phone number string")
        }
        return str
    }
    
    func isValid(number totalString: String, in range: NSRange) -> Bool {
        let firstChar = totalString.first
        if (range.location == 0)
        {
            if(firstChar == "5" || firstChar == "7") {
                return true
            }
        }
        else if(range.location == 1)
        {
            let secondChar = totalString[totalString.index(totalString.startIndex, offsetBy: 1)]
            if((firstChar == "5" && secondChar == "5") ||
                (firstChar == "7" && (secondChar == "7"
                    || secondChar == "0")))
            {
                return true
            }
        }
        else
        {
            return true
        }
        
        return false
        
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
                let end = phoneNumber.index(phoneNumber.endIndex, offsetBy: -1)
                
                phoneNumber = phoneNumber.substring(to: end)
                loginTextField.text = self.format(input: totalString, true)
                
            } else {
                if phoneNumber.count < 9 {
                    phoneNumber += string
                }
                loginTextField.text =  self.format(input: totalString, false)
            }
            print("my phone - \(phoneNumber)")
            return false
        }
        
        return true
    }
}

