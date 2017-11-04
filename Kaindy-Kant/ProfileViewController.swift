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
import ScrollableSegmentedControl
class ProfileViewController: UIViewController,  UITextFieldDelegate {
    
    
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var first_name_TF: SkyFloatingLabelTextField! {
        didSet {
            first_name_TF.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: first_name_TF, withText: "Имя", placeholder: "Имя", tag: 0)
            configureTextField(textField: first_name_TF)
        }
    }
    
    @IBOutlet weak var last_name_TF: SkyFloatingLabelTextField! {
        didSet {
            last_name_TF.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: last_name_TF, withText: "Фамилия", placeholder: "Фамилия", tag: 1)
            configureTextField(textField: last_name_TF)
        }
    }
    
    @IBOutlet weak var fathers_name_TF: SkyFloatingLabelTextField! {
        didSet {
            fathers_name_TF.accessibilityIdentifier = "fathersNameTextField"
            GlobalFunctions.configure(textField: fathers_name_TF, withText: "Отчество", placeholder: "Отчество", tag: 2)
            configureTextField(textField: fathers_name_TF)
        }
    }
    
    @IBOutlet weak var phone_TF: SkyFloatingLabelTextField!  {
        didSet {
            phone_TF.accessibilityIdentifier = "phoneTextField"
            GlobalFunctions.configure(textField: phone_TF, withText: "Телефон", placeholder: "0777-77-77", tag: 3)
            phone_TF.keyboardType = .phonePad
            configureTextField(textField: phone_TF)
        }
    }
    
    @IBOutlet weak var email_TF: SkyFloatingLabelTextField! {
        didSet {
            email_TF.accessibilityIdentifier = "emailTextField"
            GlobalFunctions.configure(textField: email_TF, withText: "Электронная Почта", placeholder: "Электронная Почта", tag: 7)
            configureTextField(textField: email_TF)
        }
    }
    
    @IBOutlet weak var date_of_birth_TF: SkyFloatingLabelTextField! {
        didSet {
            date_of_birth_TF.accessibilityIdentifier = "birthdayTextField"
            GlobalFunctions.configure(textField: date_of_birth_TF, withText: "День рождения", placeholder: "ГГГГ/ММ/ДД", tag: 4)
            date_of_birth_TF.delegate = self
            configureTextField(textField: date_of_birth_TF)
        }
    }
    
    @IBOutlet weak var address_TF: SkyFloatingLabelTextField! {
        didSet {
            address_TF.accessibilityIdentifier = "addressTextField"
            GlobalFunctions.configure(textField: address_TF, withText: "Адрес", placeholder: "Адрес", tag: 6)
            configureTextField(textField: address_TF)
        }
    }
    
    @IBOutlet weak var city_TF: SkyFloatingLabelTextField! {
        didSet {
            city_TF.accessibilityIdentifier = "cityTextField"
            GlobalFunctions.configure(textField: city_TF, withText: "Город/Село/Район", placeholder: "Город/Село/Район", tag: 5)
            configureTextField(textField: city_TF)
        }
    }
    
    
    func configureTextField(textField: SkyFloatingLabelTextField){
        textField.lineColor = UIColor.init(netHex: Colors.purple)
        textField.titleColor = UIColor.init(netHex: Colors.purple)
        textField.selectedLineColor = UIColor.init(netHex: Colors.green)
        textField.selectedTitleColor = UIColor.init(netHex: Colors.green)
       //tableView.estimatedRowHeight = 260;
        //tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!

    var years = Years().years
    var yearIndex = 0
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
//            imageView.layer.cornerRadius = imageView.frame.size.width/2
//            imageView.clipsToBounds = true
//            imageView.accessibilityIdentifier = "imageView"
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
//            imageView.isUserInteractionEnabled = true
//            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    @IBOutlet weak var noFieldsConstraint: NSLayoutConstraint!
    
    @IBAction func chagePasswordButton(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangingPasswordViewController") as! ChangingPasswordViewController
    self.navigationController?.show(vc, sender: self)
        
    }
    @IBAction func saveChangesPressed(_ sender: Any) {

        var infoToUpdate = [String: String]()
        infoToUpdate["first_name"] = self.first_name_TF.text
        infoToUpdate["last_name"] = self.last_name_TF.text
        infoToUpdate["fathers_name"] = self.fathers_name_TF.text
        infoToUpdate["phone"] = self.phone_TF.text
        infoToUpdate["email"] = self.email_TF.text
        infoToUpdate["date_of_birth"] = self.date_of_birth_TF.text
        infoToUpdate["city"] = self.city_TF.text
        infoToUpdate["address"] = self.address_TF.text
        SVProgressHUD.show()
        ServerManager.shared.updateUser(parameters: infoToUpdate, updateUser, error: showErrorAlert)
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
        self.title = "Профиль"
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
        phone_TF.text = user_info["phone"]
        email_TF.text = user_info["email"]
        address_TF.text = user_info["address"]
        date_of_birth_TF.text = user_info["date_of_birth"]
        city_TF.text = user_info["city"]
        fullNameLabel.text = "\(user_info["first_name"]!) \(user_info["last_name"]!)"
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
    
    func updateUI() {
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
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
    
    func changePassword()  {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangingPasswordViewController") as! ChangingPasswordViewController
//        self.navigationController?.show(vc, sender: self)
            }
    
    func showStartPage() {
    }
    
    func showImagePicker() {
        //        let imagePickerController = ImagePickerController()
        //        imagePickerController.imageLimit = 1
        //        imagePickerController.view.backgroundColor = UIColor.init(netHex: Colors.green)
        //        imagePickerController.delegate = self
        //        present(imagePickerController, animated: true, completion: nil)
    }
    
//    func configureRefreshControl() {
//        let refreshControl = UIRefreshControl()
//        let title = NSLocalizedString("Pull to refresh", comment: "Pull to refresh")
//        //        refreshControl.attributedTitle = NSAttributedString(string: title)
//        //        refreshControl.addTarget(self,
//        //                                 action: #selector(refreshOptions(sender:)),
//        //                                 for: .valueChanged)
//        
//        if #available(iOS 10.0, *) {
//            scrollView.refreshControl = refreshControl
//        }
//        else{
//            scrollView.addSubview(refreshControl)
//        }
//    }
    
//    func refreshOptions(sender: UIRefreshControl) {
//    }
//    
//    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
//        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
//            completion(false)
//            return
//        }
//        guard #available(iOS 10, *) else {
//            completion(UIApplication.shared.openURL(url))
//            return
//        }
//        UIApplication.shared.open(url, options: [:], completionHandler: completion)
//    }
}

//MARK: ImagePickerDelegate methods

//extension ProfileViewController: ImagePickerDelegate {
//    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        self.imageView.image = images.first
//        self.dismiss(animated: true, completion: nil)
//    }
//    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//
//    }
//
//    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//MARK: UITextFieldDelegate methods

extension ProfileViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 4 {
            showDatePicker()
            return false
        }
        return true
    }
}

