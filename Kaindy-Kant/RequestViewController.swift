//
//  RequestViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    
    var requests = ["Оправка по че-то" , "Заявка на очередь"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
}

extension RequestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCollectionViewCell", for: indexPath) as! RequestCollectionViewCell
        cell.requestLbl.text = requests[indexPath.row]
        return cell
    }
}

extension RequestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) - 13
        return CGSize(width: width, height: width)
    }
}
