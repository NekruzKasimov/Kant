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

class DetailedSceneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var finOffices: FinancialOffices?
    var detailedFinOffice: DetailedFinOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ServerManager.shared.getAllFinancialOffices(setFinancialOffices) { (error) in
            print(error)
        }
    }
}

//MARK: UITableViewDataSourse methods

extension DetailedSceneViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = finOffices?.array.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedSceneTableViewCell") as! DetailedSceneTableViewCell
        cell.logoImageView.kf.setImage(with: URL(string: (finOffices?.array[indexPath.row].logo)!))
        cell.titleLabel.text = finOffices?.array[indexPath.row].name
        return cell
    }
}

//MARK: UITableViewDelegate methods

extension DetailedSceneViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ServerManager.shared.getFinancialOfficeById(id: indexPath.row + 1, setDetailedFinancialOffice) { (error) in
            print(error)
        }
    }
}

//MARK: Helper functions

extension DetailedSceneViewController {
    
    func configureTableView() {
        tableView.estimatedRowHeight            = 100
        tableView.rowHeight                     = UITableViewAutomaticDimension
        tableView.tableFooterView               = UIView()
    }
    
    func setFinancialOffices(financialOffices: FinancialOffices) {
        self.finOffices = financialOffices
        tableView.reloadData()
    }
    
    func setDetailedFinancialOffice(detailedFinOffice: DetailedFinOffice) {
        self.detailedFinOffice = detailedFinOffice
        setBank(detailedFinOffice: detailedFinOffice)
    }

    func setBank(detailedFinOffice: DetailedFinOffice) {
        let storyboard = UIStoryboard(name: "DetailedService", bundle: nil)
        let headerVC = storyboard.instantiateViewController(
            withIdentifier: "HeaderViewController") as! HeaderViewController
        headerVC.finOffice = detailedFinOffice

        let aboutVC = storyboard.instantiateViewController(
            withIdentifier: "DescriptionViewController") as! DescriptionViewController
        aboutVC.title = "Описание"
        aboutVC.desc = detailedFinOffice.description

        
        let mapVC = storyboard.instantiateViewController(
            withIdentifier: "BranchesViewController") as! BranchesViewController
        mapVC.title = "Карта"

        var titles = [String]()
        var locations = [Location]()
        for item in (detailedFinOffice.branches?.array)!{
            titles.append(item.address)
            let location = Location.init(latitude: item.latitude, longitude: item.longitude)
            locations.append(location)
        }
        mapVC.titles = titles
        mapVC.loc = locations


        let contactsVC = storyboard.instantiateViewController(
            withIdentifier: "ContactsViewController") as! ContactsViewController
        contactsVC.title = "Контакты"
        contactsVC.contacts = detailedFinOffice.contacts


//        let servicesVC = storyboard.instantiateViewController(
//            withIdentifier: "ServicesVC") as! ServicesVC
//        servicesVC.title = "Услуги"
//        servicesVC.services = course.services

//            headerViewController = headerVC
        let segmentControllers = SJSegmentedViewController(
            headerViewController: headerVC,
            segmentControllers: [aboutVC, mapVC, contactsVC])
        segmentControllers.headerViewHeight = 260
        segmentControllers.selectedSegmentViewHeight = 5.0
        segmentControllers.segmentTitleColor = .gray
        segmentControllers.selectedSegmentViewColor = .red
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



