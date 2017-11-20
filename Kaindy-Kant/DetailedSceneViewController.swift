//
//  DetailedSceneViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import Kingfisher
import SJSegmentedScrollView

class DetailedSceneViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailedServices: DetailedServices?
    var serviceTitle: String?
    
    var isSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = serviceTitle
    }
}

//MARK: UITableViewDataSourse methods

extension DetailedSceneViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = detailedServices?.array.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedSceneTableViewCell") as! DetailedSceneTableViewCell
        cell.logoImageView.kf.setImage(with: URL(string: (detailedServices?.array[indexPath.row].logo)!))
        cell.titleLabel.text = detailedServices?.array[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}

//MARK: UITableViewDelegate methods

extension DetailedSceneViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setBank(detailedService: (detailedServices?.array[indexPath.row])!)
    }
}

//MARK: Helper functions

extension DetailedSceneViewController {
    
    func setBank(detailedService: DetailedService) {
        let storyboard = UIStoryboard(name: "DetailedService", bundle: nil)
        let headerVC = storyboard.instantiateViewController(
            withIdentifier: "HeaderViewController") as! HeaderViewController
        headerVC.finOffice = detailedService

        let aboutVC = storyboard.instantiateViewController(
            withIdentifier: "DescriptionViewController") as! DescriptionViewController
        aboutVC.title = "description".localized(lang: self.lang)!
        aboutVC.desc = detailedService.description

        for item in (detailedService.contacts?.array)! {
            if item.type == "web" {
                aboutVC.webSite = item.data
            }
        }

        
        let mapVC = storyboard.instantiateViewController(
            withIdentifier: "BranchesViewController") as! BranchesViewController
        mapVC.title = "Карта"

        var titles = [String]()
        var locations = [Location]()
        for item in (detailedService.branches?.array)!{
            titles.append(item.address)
            let location = Location.init(latitude: item.latitude, longitude: item.longitude)
            locations.append(location)
        }
        mapVC.titles = titles
        mapVC.loc = locations


        let contactsVC = storyboard.instantiateViewController(
            withIdentifier: "ContactsViewController") as! ContactsViewController
        contactsVC.title = "contacts".localized(lang: self.lang)!
        contactsVC.contacts = detailedService.contacts


//        let servicesVC = storyboard.instantiateViewController(
//            withIdentifier: "ServicesVC") as! ServicesVC
//        servicesVC.title = "Услуги"
//        servicesVC.services = course.services

//            headerViewController = headerVC
        let segmentControllers = SJSegmentedViewController(
            headerViewController: headerVC,
            segmentControllers: [aboutVC, mapVC, contactsVC])
        segmentControllers.headerViewHeight = 200
        segmentControllers.title = detailedService.title
        segmentControllers.selectedSegmentViewHeight = 3.0
        segmentControllers.segmentTitleColor = .gray
        segmentControllers.selectedSegmentViewColor = UIColor.init(netHex: Colors.purple)
        segmentControllers.segmentShadow = SJShadow.light()
        segmentControllers.showsHorizontalScrollIndicator = false
        segmentControllers.showsVerticalScrollIndicator = false

//                if !(navigationController?.navigationBar.isOpaque)! {
//
//                    topSpacing += (navigationController?.navigationBar.bounds.height)!
//                }
//
//        segmentControllers.delegate = self

        navigationController?.pushViewController(segmentControllers, animated: true)
        //segmentControllers
        //navigationController?.present(segmentControllers, animated: false, completion: nil)
        //?.pushViewController(segmentControllers, animated: true)

    }
}



