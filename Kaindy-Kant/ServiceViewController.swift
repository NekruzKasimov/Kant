//
//  ServiceViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    var services = [["Банки", "bank"], ["Услуги по консультации", "consultation"], ["Информация о почвах лаборатории", "laboratory"]]

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
        cell.serviceLbl.text = services[indexPath.row][0]
        cell.serviceLbl.numberOfLines = 0
        cell.serviceImg.image = UIImage(named: services[indexPath.row][1])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let sb = UIStoryboard(name: "DetailedService", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "DetailedServiceViewController") as! DetailedServiceViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) - 13
        return CGSize(width: width, height: width)
    }
}
