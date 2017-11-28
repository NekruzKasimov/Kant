//
//  HeaderViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import ImageSlideshow

class HeaderViewController: UIViewController {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    var finOffice: DetailedService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSlideImageView()
        self.title = finOffice.title
        self.modalPresentationCapturesStatusBarAppearance = true
        let myimage = UIImage(named: "back-5")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(goBack))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setSlideImageView() {
        var images: [String] = []
        for item in (finOffice.images?.array)! {
            images.append(item.image)
        }
        
        if (images.count != 0) {
            var imageArray = [InputSource]()
            var count = 0
            for imageModel in images {
                guard  let url = URL(string: imageModel) else {
                    return
                }
                imageArray.append(KingfisherSource(url: url))
                
                count += 1
            }
            slideShow.setImageInputs(imageArray)
        } else {
            let url = URL(string: finOffice.logo)!
            var imageArray = [InputSource]()
            imageArray.append(KingfisherSource(url: url))
            slideShow.setImageInputs(imageArray)
        }
        
        slideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor.init(netHex: Colors.purple)
    }
}

