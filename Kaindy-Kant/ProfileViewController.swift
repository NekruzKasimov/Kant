//
//  ProfileViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD
import SkyFloatingLabelTextField
//import BetterSegmentedControl
//import PageMenu
import Photos
import ScrollableSegmentedControl

class ProfileViewController: ViewController,  UITextFieldDelegate {
    
    @IBOutlet weak var changePasswordButton: UIButton! {
        didSet {
            changePasswordButton.setTitle(Constants.Values.changePassword, for: .normal)
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle(Constants.Values.save, for: .normal)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myFieldsButton: UIButton! {
        didSet {
            myFieldsButton.setTitle(Constants.MainPage.myFields, for: .normal)
        }
    }
    
    var imagePicker = UIImagePickerController()
    var image = ""
    var phoneNumber = ""
    
    @IBOutlet weak var first_name_TF: SkyFloatingLabelTextField! {
        didSet {
            first_name_TF.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: first_name_TF, withText: "name".localized(lang: self.lang)!, placeholder: "name".localized(lang: self.lang)! , tag: 0)
            configureTextField(textField: first_name_TF)
        }
    }
    
    @IBOutlet weak var last_name_TF: SkyFloatingLabelTextField! {
        didSet {
            last_name_TF.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: last_name_TF, withText: "surname".localized(lang: self.lang)! , placeholder: "surname".localized(lang: self.lang)! , tag: 1)
            configureTextField(textField: last_name_TF)
        }
    }
    
    @IBOutlet weak var fathers_name_TF: SkyFloatingLabelTextField! {
        didSet {
            fathers_name_TF.accessibilityIdentifier = "fathersNameTextField"
            GlobalFunctions.configure(textField: fathers_name_TF, withText: "fathers_name".localized(lang: self.lang)!, placeholder: "fathers_name".localized(lang: self.lang)!, tag: 2)
            configureTextField(textField: fathers_name_TF)
        }
    }
    
    @IBOutlet weak var phone_TF: SkyFloatingLabelTextField!  {
        didSet {
            phone_TF.accessibilityIdentifier = "phoneTextField"
            GlobalFunctions.configure(textField: phone_TF, withText: "phone".localized(lang: self.lang)! , placeholder: "(XXX) YY-YY-YY", tag: 3)
            phone_TF.keyboardType = .phonePad
            phone_TF.delegate = self
            configureTextField(textField: phone_TF)
        }
    }
    
    @IBOutlet weak var email_TF: SkyFloatingLabelTextField! {
        didSet {
            email_TF.accessibilityIdentifier = "emailTextField"
            GlobalFunctions.configure(textField: email_TF, withText: "email".localized(lang: self.lang)! , placeholder: "email".localized(lang: self.lang)! , tag: 7)
            configureTextField(textField: email_TF)
        }
    }
    
    @IBOutlet weak var date_of_birth_TF: SkyFloatingLabelTextField! {
        didSet {
            date_of_birth_TF.accessibilityIdentifier = "birthdayTextField"
            GlobalFunctions.configure(textField: date_of_birth_TF, withText: "birth_date".localized(lang: self.lang)! , placeholder: "ГГГГ/ММ/ДД", tag: 4)
            date_of_birth_TF.delegate = self
            configureTextField(textField: date_of_birth_TF)
        }
    }
    
    @IBOutlet weak var address_TF: SkyFloatingLabelTextField! {
        didSet {
            address_TF.accessibilityIdentifier = "addressTextField"
            GlobalFunctions.configure(textField: address_TF, withText: "address".localized(lang: self.lang)!, placeholder: "address".localized(lang: self.lang)!, tag: 6)
            configureTextField(textField: address_TF)
        }
    }
    
    @IBOutlet weak var city_TF: SkyFloatingLabelTextField! {
        didSet {
            city_TF.accessibilityIdentifier = "cityTextField"
            GlobalFunctions.configure(textField: city_TF, withText: "city".localized(lang: self.lang)!, placeholder: "city".localized(lang: self.lang)!, tag: 5)
            configureTextField(textField: city_TF)
        }
    }
    
    
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!

    @IBOutlet weak var avatarImageView: UIImageView!{
        didSet{
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
            avatarImageView.clipsToBounds = true
            avatarImageView.accessibilityIdentifier = "avatarImageView"
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
            avatarImageView.isUserInteractionEnabled = true
            avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    @IBOutlet weak var noFieldsConstraint: NSLayoutConstraint!
    
    @IBAction func chagePasswordButton(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManagingPasswordViewController") as! ManagingPasswordViewController
    self.navigationController?.show(vc, sender: self)
        
    }
    @IBAction func saveChangesPressed(_ sender: Any) {

        SVProgressHUD.show()
        ServerManager.shared.updateUser(parameters: getInfoToUpdate(), updateUser, error: showErrorAlert)
    }
    func getInfoToUpdate() -> [String: String] {
        var infoToUpdate = [String: String]()
        infoToUpdate["first_name"] = self.first_name_TF.text
        infoToUpdate["last_name"] = self.last_name_TF.text
        infoToUpdate["fathers_name"] = self.fathers_name_TF.text
        infoToUpdate["phone"] = self.phone_TF.text
        infoToUpdate["email"] = self.email_TF.text
        infoToUpdate["date_of_birth"] = self.date_of_birth_TF.text
        infoToUpdate["city"] = self.city_TF.text
        infoToUpdate["address"] = self.address_TF.text
        infoToUpdate["photo"] = self.image
        return infoToUpdate
    }
    func updateUser(user: NewUser){
        SVProgressHUD.dismiss()
        DataManager.shared.saveUserInformation(userDictionary: user.toDictionary() as! [String : String])
        fillUserInformation()
    }
    
//    @IBOutlet weak var changePasswordButton: UIButton! {
//        didSet{
//            changePasswordButton.accessibilityIdentifier = "changePasswordButton"
//            let attrs:[String : Any] = [
//                NSFontAttributeName : UIFont.systemFont(ofSize: 18.0),
//                NSForegroundColorAttributeName : UIColor.init(netHex: Colors.gray),
//                NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue
//            ]
//            let attributeString = NSMutableAttributedString(string: "Поменять пароль",
//                                                            attributes: attrs)
//            changePasswordButton.setAttributedTitle(attributeString, for: .normal)
//            changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureRefreshControl()
//        addTapToScrollView()
        self.title = "my_profile".localized(lang: self.lang)!
        setNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillUserInformation()
    }
    
    func fillUserInformation() {
        let user_info = DataManager.shared.getUserInformation()!
        first_name_TF.text = user_info["first_name"]
        last_name_TF.text = user_info["last_name"]
        fathers_name_TF.text = user_info["fathers_name"]
        phone_TF.text = setPhoneNumber(phone: user_info["phone"])
        phoneNumber = phone_TF.text!
        email_TF.text = user_info["email"]
        address_TF.text = user_info["address"]
        date_of_birth_TF.text = user_info["date_of_birth"]
        city_TF.text = user_info["city"]
        fullNameLabel.text = "\(user_info["first_name"]!) \(user_info["last_name"]!)"
        let imageToDecode = user_info["photo"]
        if imageToDecode == "" {
            avatarImageView.image = UIImage(named: "camera")
        } else {
            avatarImageView.image = imageToDecode?.decode64(imageData: imageToDecode!)
            self.image = imageToDecode!
        }
    }
    
    @IBAction func presentMap(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FieldViewController") as! FieldViewController
        self.navigationController?.show(vc, sender: self)
    }
}


extension ProfileViewController {
    
//    func addTapToScrollView() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        
//        scrollView.addGestureRecognizer(tap)
//    }
//    
//    func dismissKeyboard() {
//        scrollView.endEditing(true)
//    }
    
    func setPhoneNumber(phone: String?) -> String {
        var response = ""
        var counter = 0
        for item in (phone?.characters)! {
            if counter == 0 {
                response = response + "("
            } else if counter == 3 {
                response = response + ") "
            } else if counter == 5 || counter == 7 {
                response = response + "-"
            }
            counter = counter + 1
            response = response + String(describing: item)
        }
        
        return response
    }
    
    func showDatePicker() {
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x:0,y:15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(myDatePicker)
        alertController.view.tintColor = .black
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            self?.date_of_birth_TF.text = dateFormatter.string(from: myDatePicker.date)
        }
        let cancelAction = UIAlertAction(title: Constants.Values.cancel, style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
    
    func showImagePicker() {
        let alert = UIAlertController(title: Constants.Values.chooseImage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: Constants.Values.cancel , style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
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

//MARK: UITextFieldDelegate methods

extension ProfileViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 4 {
            showDatePicker()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        let totalString = "\(phone_TF.text!)\(string)"
        //        if !self.isValid(number: totalString, in: range) {
        //            return false
        //        }
        
        if(phone_TF.tag == 3) {
            if (range.location == 0 && string == "0") { return false }
            if (range.length == 1) {
                let end = phoneNumber.index(phoneNumber.endIndex, offsetBy: -1)
                
                phoneNumber = phoneNumber.substring(to: end)
                phone_TF.text = PhoneNumbers.format(input: totalString, true)
                
            } else {
                if phoneNumber.count < 9 {
                    phoneNumber += string
                }
                phone_TF.text = PhoneNumbers.format(input: totalString, false)
            }
            print("my phone - \(phoneNumber)")
            return false
        }
        
        return true
    }
}

//MARK UIImagePickerController delegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion:nil)
        let imageToResize = info[UIImagePickerControllerEditedImage] as! UIImage
        let imageToEncode = imageToResize.resized(withPercentage: 0.4)
        DispatchQueue.main.async {
            self.avatarImageView.image = imageToEncode
        }
        self.image = (imageToEncode?.encode64(image: imageToEncode!))!
        DataManager.shared.saveUserInformation(userDictionary: getInfoToUpdate())
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}
