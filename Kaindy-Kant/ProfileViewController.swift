//
//  ProfileViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
//import BetterSegmentedControl
//import PageMenu
import ScrollableSegmentedControl
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
   
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var yearTitle = "2010"
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
    @IBOutlet weak var myFieldsLable: UILabel!

    @IBOutlet weak var birthdayTF: UITextField! {
        didSet {
            birthdayTF.delegate = self
            birthdayTF.tag = 0
        }
    }
    
    @IBAction func chagePasswordButton(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangingPasswordViewController") as! ChangingPasswordViewController
    self.navigationController?.show(vc, sender: self)
        
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
        segmentedControl.selectedSegmentIndex = 0
        addScrollableSegmentControl()
        print(myFieldsLable.frame.origin.y)
        
    }
    func addScrollableSegmentControl(){
        segmentedControl.segmentStyle = .textOnly
        for index in 0..<10 {
            segmentedControl.insertSegment(withTitle: "201\(index)", at: index)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.underlineSelected = true
        segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        // change some colors
        segmentedControl.segmentContentColor = UIColor.black
        segmentedControl.selectedSegmentContentColor = UIColor.black
        segmentedControl.backgroundColor = UIColor.white
    }
    func segmentSelected(sender:ScrollableSegmentedControl) {
        //segmentedControl
        yearTitle = "201\(sender.selectedSegmentIndex)"
        tableView.reloadData()
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
    }
    @IBAction func presentMap(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
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
            self?.birthdayTF.text = dateFormatter.string(from: myDatePicker.date)
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
    
    func configureTableView() {
        tableView.register(ProfileMapTableViewCell.self, forCellReuseIdentifier: "ProfileMapTableViewCell" )
        tableView.register(UINib(nibName: "ProfileMapTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileMapTableViewCell")
        tableView.estimatedRowHeight        = 320
        tableView.rowHeight                 = UITableViewAutomaticDimension
        tableView.tableFooterView           = UIView()
        tableViewHeight.constant            = tableView.contentSize.height
        tableView.separatorStyle            = .none
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
        if textField.tag == 0 {
            showDatePicker()
            return false
        }
        return true
    }
}

extension ProfileViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMapTableViewCell") as! ProfileMapTableViewCell
        cell.yearLabel.text = yearTitle
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailedMapViewController") as! DetailedMapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
}
