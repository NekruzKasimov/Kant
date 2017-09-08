//
//  ProfileViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FontAwesome_swift

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = imageView.frame.size.width/2
            imageView.clipsToBounds = true
            imageView.accessibilityIdentifier = "imageView"
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            firstNameTF.accessibilityIdentifier = "firstNameTextField"
            GlobalFunctions.configure(textField: firstNameTF,
                                      withText: "First name",
                                      placeholder: "First name",
                                      tag:1)
            configure(textField: firstNameTF, with: .user)
        }
    }
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            lastNameTF.accessibilityIdentifier = "lastNameTextField"
            GlobalFunctions.configure(textField: lastNameTF,
                                      withText: "Last name",
                                      placeholder: "Last name",
                                      tag:2)
            configure(textField: lastNameTF, with: .user)
        }
    }
    @IBOutlet weak var birthdayTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            birthdayTF.accessibilityIdentifier = "birthdayTextField"
            GlobalFunctions.configure(textField: birthdayTF,
                                      withText: "Birthday",
                                      placeholder: "Birthday",
                                      tag:3)
            configure(textField: birthdayTF, with: .birthdayCake)
        }
    }
    //    @IBOutlet weak var emailTF: SkyFloatingLabelTextFieldWithIcon! {
    //        didSet{
    //            emailTF.accessibilityIdentifier = "emailTextField"
    //            GlobalFunctions.configure(textField: emailTF,
    //                                      withText: "Email",
    //                                      placeholder: "Email",
    //                                      tag:4)
    //            configure(textField: emailTF, with: .envelope)
    //
    //        }
    //    }
    
    @IBOutlet weak var phoneNumberTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            phoneNumberTF.accessibilityIdentifier = "phoneNumberTextField"
            GlobalFunctions.configure(textField: phoneNumberTF,
                                      withText: "Phone number",
                                      placeholder: "Phone number",
                                      tag:4)
            configure(textField: phoneNumberTF, with: .phone)
        }
    }
    
    @IBOutlet weak var countryTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            countryTF.accessibilityIdentifier = "countryTextField"
            GlobalFunctions.configure(textField: countryTF,
                                      withText: "Country",
                                      placeholder: "Country",
                                      tag: 5)
            configure(textField: countryTF, with: .map)
        }
    }
    
    @IBOutlet weak var regionTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            regionTF.accessibilityIdentifier = "regionTextField"
            GlobalFunctions.configure(textField: regionTF,
                                      withText: "Region",
                                      placeholder: "Region",
                                      tag: 6)
            configure(textField: regionTF, with: .mapMarker)
        }
    }
    
    @IBOutlet weak var cityTF: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            cityTF.accessibilityIdentifier = "cityTextField"
            GlobalFunctions.configure(textField: cityTF,
                                      withText: "City",
                                      placeholder: "City",
                                      tag: 7)
            configure(textField: cityTF, with: .mapPin)
            
        }
    }
    
    @IBOutlet weak var saveButton: LoadingIndicatorButton! {
        didSet{
            saveButton.accessibilityIdentifier = "saveButton"
            saveButton.buttonTitle = "Save"
            saveButton.bc = UIColor.init(netHex: Colors.green)
        }
    }
    @IBOutlet weak var logoutButton: LoadingIndicatorButton! {
        didSet{
            logoutButton.accessibilityIdentifier = "logoutButton"
            logoutButton.buttonTitle = "Logout"
            logoutButton.bc = UIColor(netHex: Colors.yellow)
        }
    }
    
    @IBAction func signOut(_ sender: UIButton){
        signOut()
    }
    
    func changePassword() {
    }
    
    @IBAction func saveUser(_ sender:UIButton){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        addTapToScrollView()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension ProfileViewController {
    
    func addTapToScrollView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        scrollView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        scrollView.endEditing(true)
    }
    
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
            self?.birthdayTF.text = dateFormatter.string(from: myDatePicker.date)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
    
    func configure(textField: SkyFloatingLabelTextFieldWithIcon, with iconName:FontAwesome) {
        textField.delegate = self
        textField.iconFont = UIFont.fontAwesome(ofSize: 18)
        textField.iconText = String.fontAwesomeIcon(name: iconName)
        textField.iconColor = .black
        textField.iconMarginBottom = 0
    }
    
    func signOut()  {
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
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Pull to refresh", comment: "Pull to refresh")
        //        refreshControl.attributedTitle = NSAttributedString(string: title)
        //        refreshControl.addTarget(self,
        //                                 action: #selector(refreshOptions(sender:)),
        //                                 for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            scrollView.refreshControl = refreshControl
        }
        else{
            scrollView.addSubview(refreshControl)
        }
    }
    
    func refreshOptions(sender: UIRefreshControl) {
    }
    
    func showShareAppPage() {
        let myAppId = 23523523 //TODO: put real app id in iTunes
        if let name = NSURL(string: "https://itunes.apple.com/us/app/myapp/id\(myAppId)?ls=1&mt=8") {
            let objectsToShare = [name]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)
        }
        else
        {
            // show alert for not available
        }
    }
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
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

extension ProfileViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        if textField.tag == 7 {
        //            showShareAppPage()
        //            return false
        //        } else if textField.tag == 9 {
        //            return false
        //        }
        //        else if textField.tag == 6 {
        //            return false
        //        }
        //        else if textField.tag == 3 {
        //            showDatePicker()
        //            return false
        //        } else if textField.tag == 8 {
        //            changePassword()
        //            return false
        //        }
        //        else{
        return true
        //        }
    }
}
