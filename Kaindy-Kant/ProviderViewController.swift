//
//  ProviderViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProviderViewController: ViewController,  UICollectionViewDataSource, UISearchControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
            collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        }
    }
    
    var suppliers: Services?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        SVProgressHUD.show()
        ServerManager.shared.getSuppliers(setSuppliers) { (error) in
            self.showErrorAlert(message: error)
            SVProgressHUD.dismiss()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "suppliers".localized(lang: self.lang)!
    }
    
    func setSuppliers(suppliers: Services) {
        self.suppliers = suppliers
        collectionView.reloadData()
    }
}
//MARK: UICollectionViewDataSourse methods
extension ProviderViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = suppliers?.array.count {
            SVProgressHUD.dismiss()
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
        
        cell.titleLabel.text = suppliers?.array[indexPath.row].name
        
        cell.imageView.kf.setImage(with: URL(string: (suppliers?.array[indexPath.row].logo)!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24
        let size = CGSize(width: width, height: 150)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailedService", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailedSceneViewController") as! DetailedSceneViewController
        vc.detailedServices = suppliers?.array[indexPath.row].detailedServices
        vc.serviceTitle = suppliers?.array[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }

}
