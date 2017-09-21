//
//  ProfileViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
//    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
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
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
//        let myDatePicker = UIDatePicker()
//        myDatePicker.datePickerMode = .date
//        myDatePicker.frame = CGRect(x:0,y:15, width: 270, height: 200)
//        
//        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
//        alertController.view.addSubview(myDatePicker)
//        alertController.view.tintColor = .black
//        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy"
//            dateFormatter.locale = Locale.init(identifier: "en_GB")
//            self?.birthdayTF.text = dateFormatter.string(from: myDatePicker.date)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion:{})
    }
    
    func changePassword()  {
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMapTableViewCell") as! ProfileMapTableViewCell
        return cell
    }
}
