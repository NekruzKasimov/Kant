//
//  RegistrationViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FontAwesome_swift

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            firstNameTF.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: firstNameTF,
                                      withText: "Имя",
                                      placeholder: "Имя",
                                      tag:1)
            configure(textField: firstNameTF, with: .deaf)
        }
    }

    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            lastNameTF.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: lastNameTF,
                                      withText: "Фамилия",
                                      placeholder: "Фамилия",
                                      tag:2)
            configure(textField: lastNameTF, with: .user)
        }
    }
    
    @IBOutlet weak var phoneTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            phoneTF.accessibilityIdentifier = "phoneNumberTextField"
            GlobalFunctions.configure(textField: phoneTF,
                                      withText: "Номер телефона",
                                      placeholder: "Номер телефона",
                                      tag:3)
            configure(textField: phoneTF, with: .phone)
        }
    }
    
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            passwordTF.accessibilityIdentifier = "passwordTF"
            GlobalFunctions.configure(textField: passwordTF,
                                      withText: "Пароль",
                                      placeholder: "Пароль",
                                      tag:4)
            configure(textField: passwordTF, with: .youTube)
        }
    }
    
    @IBOutlet weak var confirmPasswordTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            confirmPasswordTF.accessibilityIdentifier = "confirmPasswordTF"
            GlobalFunctions.configure(textField: confirmPasswordTF,
                                      withText: "Подтвердить пароль",
                                      placeholder: "Подтвердить пароль",
                                      tag:5)
            configure(textField: confirmPasswordTF, with: .amazon)
        }
    }
    
    func configure(textField: SkyFloatingLabelTextFieldWithIcon, with iconName:FontAwesome) {
        textField.delegate = self
        textField.iconFont = UIFont.fontAwesome(ofSize: 18)
        textField.iconText = String.fontAwesomeIcon(name: iconName)
        textField.iconColor = .black
        textField.iconMarginBottom = 0
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
