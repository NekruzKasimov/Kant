//
//  RegistrationViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Photos
import SVProgressHUD

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    var imagePicker = UIImagePickerController()
    var image = ""
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
            avatarImageView.clipsToBounds = true
            avatarImageView.accessibilityIdentifier = "avatarImageView"
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
            avatarImageView.isUserInteractionEnabled = true
            avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField! {
        didSet {
            firstNameTF.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: firstNameTF, withText: "Имя", placeholder: "Имя", tag: 0)
            configureTextField(textField: firstNameTF)
        }
    }
    
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField! {
        didSet {
            lastNameTF.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: lastNameTF, withText: "Фамилия", placeholder: "Фамилия", tag: 1)
            configureTextField(textField: lastNameTF)
        }
    }
    
    @IBOutlet weak var fathersNameTF: SkyFloatingLabelTextField! {
        didSet {
            fathersNameTF.accessibilityIdentifier = "fathersNameTextField"
            GlobalFunctions.configure(textField: fathersNameTF, withText: "Отчество", placeholder: "Отчество", tag: 2)
            configureTextField(textField: fathersNameTF)
        }
    }
    
    @IBOutlet weak var phoneTF: SkyFloatingLabelTextField! {
        didSet {
            phoneTF.accessibilityIdentifier = "phoneTextField"
            GlobalFunctions.configure(textField: phoneTF, withText: "Телефон", placeholder: "Телефон", tag: 3)
            phoneTF.keyboardType = .phonePad
            configureTextField(textField: phoneTF)
        }
    }
    
    @IBOutlet weak var birthdayTF: SkyFloatingLabelTextField! {
        didSet {
            birthdayTF.accessibilityIdentifier = "birthdayTextField"
            GlobalFunctions.configure(textField: birthdayTF, withText: "День рождения", placeholder: "ГГГГ/ММ/ДД", tag: 4)
            birthdayTF.delegate = self
            configureTextField(textField: birthdayTF)
        }
    }
    
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField! {
        didSet {
            cityTF.accessibilityIdentifier = "cityTextField"
            GlobalFunctions.configure(textField: cityTF, withText: "Город/Село/Район", placeholder: "Город/Село/Район", tag: 5)
            configureTextField(textField: cityTF)
        }
    }
    
    @IBOutlet weak var addressTF: SkyFloatingLabelTextField! {
        didSet {
            addressTF.accessibilityIdentifier = "addressTextField"
            GlobalFunctions.configure(textField: addressTF, withText: "Адрес", placeholder: "Адрес", tag: 6)
            configureTextField(textField: addressTF)
        }
    }
    
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField! {
        didSet {
            emailTF.accessibilityIdentifier = "emailTextField"
            GlobalFunctions.configure(textField: emailTF, withText: "Электронная почта", placeholder: "Электронная почта", tag: 7)
            configureTextField(textField: emailTF)
        }
    }
    
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField! {
        didSet {
            passwordTF.accessibilityIdentifier = "passwordTextField"
            GlobalFunctions.configure(textField: passwordTF, withText: "Пароль", placeholder: "Пароль", tag: 8)
            configureTextField(textField: passwordTF)
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var passwordRepeatTF: SkyFloatingLabelTextField! {
        didSet {
            passwordRepeatTF.accessibilityIdentifier = "passwordRepeatTextField"
            GlobalFunctions.configure(textField: passwordRepeatTF, withText: "Повторить пароль", placeholder: "Повторить пароль", tag: 9)
            configureTextField(textField: passwordRepeatTF)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = NSLocalizedString("Регистрация", comment: "Регистрация")
    }
    
    @IBAction func saveButton(_ sender: Any) {
        SVProgressHUD.show()
        let newUser = NewUser()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Registration", bundle:nil)
        if birthdayTF.text! != "" && phoneTF.text! != "" && passwordTF.text! != "" && passwordRepeatTF.text! != "" {
            
            if passwordTF.text! != passwordRepeatTF.text! {
                showErrorAlert(message: "Пароли не совпадают!")
            }
            else if passwordTF.text!.count < 4 {
                showErrorAlert(message: "Пароль должен состоять из 4 и более символов!")
            }
            else if (phoneTF.text?.count)! < 10 {
                showErrorAlert(message: "Введите правильный номер телефона!")

            } else {
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
                newUser.email = self.emailTF.text!
                newUser.photo = image
                ServerManager.shared.signUp(newUser: newUser, completion: { (user_id) in
                    DataManager.shared.setUserId(user_id: user_id)
                    DataManager.shared.setNewUser(newUser: newUser)
                    DataManager.shared.saveUser(username: DataManager.shared.getNewUser().phone, password: DataManager.shared.getNewUser().password)
                    SVProgressHUD.dismiss()
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
                    self.present(nextViewController!, animated:true, completion:nil)
                }, error: { (error) in
                    print(error)
                })
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
        let okAction = UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            self?.birthdayTF.text = dateFormatter.string(from: myDatePicker.date)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
    
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
    }
    
    func showImagePicker() {
        let alert = UIAlertController(title: "Выбрать картинку", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Предупреждение", message: "У вас нет Камеры", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        imagePicker.delegate = self
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        imagePicker.delegate = self
    }
}


// MARK: UITextFieldDelegate methods

extension RegistrationViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 4 {
            showDatePicker()
            return false
        } else {
            return true
        }
    }
}

//MARK UIImagePickerController delegate

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion:nil)
        let imageToResize = info[UIImagePickerControllerEditedImage] as! UIImage
        let imageToEncode = imageToResize.resized(withPercentage: 0.4)
        self.avatarImageView.image = imageToEncode
        self.image = (imageToEncode?.encode64(image: imageToEncode!))!
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}
