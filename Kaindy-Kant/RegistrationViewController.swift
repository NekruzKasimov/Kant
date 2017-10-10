//
//  RegistrationViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var birthdayTF: UITextField! {
        didSet {
            birthdayTF.delegate = self
            birthdayTF.tag = 0
        }
    }
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var fathersNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordRepeatTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = NSLocalizedString("Регистрация", comment: "Регистрация")
    }
    @IBAction func saveButton(_ sender: Any) {
        var newUser = NewUser()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Registration", bundle:nil)
        if birthdayTF.text! != "" && phoneTF.text! != "" && passwordTF.text! != "" && passwordRepeatTF.text! != "" {
            
            if passwordTF.text! != passwordRepeatTF.text! {
                showErrorAlert(message: "Пароли не совпадают!")
            }
            else if passwordTF.text!.count < 4 {
                showErrorAlert(message: "Пароль должен состоять из 4 и более символов!")
            }
            else {
                newUser.first_name = self.firstNameTF.text!
                newUser.last_name = self.lastNameTF.text!
                newUser.fathers_name = self.fathersNameTF.text!
                newUser.phone = self.phoneTF.text!
                newUser.city = self.cityTF.text!
                newUser.address = self.addressTF.text!
                newUser.password_repeat = self.passwordRepeatTF.text!
                newUser.password = self.passwordTF.text!
                newUser.first_name = self.firstNameTF.text!
                newUser.date_of_birth = self.birthdayTF.text!
                DataManager.shared.setNewUser(newUser: newUser)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
                self.present(nextViewController!, animated:true, completion:nil)
            }
        
        }
        else {
            showErrorAlert(message: "Fill required data")
        }
    }
}

// MARK: Helper functions

extension RegistrationViewController {
    func showDatePicker() {
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x:0,y:15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(myDatePicker)
        alertController.view.tintColor = .black
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            self?.birthdayTF.text = dateFormatter.string(from: myDatePicker.date)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
}


// MARK: UITextFieldDelegate methods

extension RegistrationViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            showDatePicker()
            return false
        } else {
            return true
        }
    }
}
