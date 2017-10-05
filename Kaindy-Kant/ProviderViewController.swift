//
//  ProviderViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController,  UICollectionViewDataSource, UISearchControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
            collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        }
    }
    
    var providers = [["Поставщики удобрений", "fertilizer"] , ["Поставщики средств защиты", "remedies"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
}
//MARK: UICollectionViewDataSourse methods
extension ProviderViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return providers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
        
        cell.titleLabel.text = providers[indexPath.row][0]
        cell.imageView.image = UIImage(named: providers[indexPath.row][1])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width - 10
        width = width / 2
        let size = CGSize(width: width, height: width)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailProvider", bundle: nil)
        var nameOfVC: String!
        
        switch indexPath.row {
        case 0:
            nameOfVC = "ContactOfResourcesViewController"
            break
        case 1:
            nameOfVC = "ContactOfResourceProtectionViewController"
            break
        default:
            break
        }
        
        let vc = sb.instantiateViewController(withIdentifier: nameOfVC)
        navigationController?.pushViewController(vc, animated: true)
    }

}
