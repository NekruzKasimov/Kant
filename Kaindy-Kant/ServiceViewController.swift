//
//  ServiceViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
            collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        }
    }
    
    var services: Services?
    
//    var logos = ["bank", "consultation", "laboratory"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        self.services = DataManager.shared.getServices()
        setNavigationBar()
    }
    
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = services?.array.count {
            SVProgressHUD.dismiss()
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for:
            indexPath) as! ServiceCollectionViewCell
        
        cell.titleLabel.text = services?.array[indexPath.row].name
        cell.imageView.kf.setImage(with: URL(string: (services?.array[indexPath.row].logo)!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailedService", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailedSceneViewController") as! DetailedSceneViewController
        vc.detailedServices = services?.array[indexPath.row].detailedServices
        vc.serviceTitle = services?.array[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24
        let size = CGSize(width: width, height: 150)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
}

