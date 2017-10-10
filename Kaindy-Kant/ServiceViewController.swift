//
//  ServiceViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
            collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        }
    }
    
    var services = [["Финансовые учреждения", "bank"], ["Консультации", "consultation"], ["Лаборатории", "laboratory"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for:
            indexPath) as! ServiceCollectionViewCell
        
        cell.titleLabel.text = services[indexPath.row][0]
        cell.imageView.image = UIImage(named: services[indexPath.row][1])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailedService", bundle: nil)
        var serviceVC = "DetailedSceneViewController"
        if indexPath.row == 1 {
            serviceVC = "ConsultationServiceViewController"
        }
        let vc = sb.instantiateViewController(withIdentifier: serviceVC)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width - 10
        width = width / 2
        let size = CGSize(width: width, height: width)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

