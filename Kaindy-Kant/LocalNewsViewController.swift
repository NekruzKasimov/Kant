//
//  LocalNewsViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 17.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import ImageSlideshow

class LocalNewsViewController: ViewController {

    @IBOutlet weak var localNewsSlideShow: ImageSlideshow!
    @IBOutlet weak var localNewsTitle: UILabel!
    @IBOutlet weak var localNewsContent: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var newsTitle = ""
    var newsContent = ""
    var images: NewsPhotos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if images?.array.count != 0 {
            setupSlideShow()
        } else {
            heightConstraint.constant = 0
            localNewsSlideShow.isHidden = true
        }
        localNewsTitle.text = newsTitle
        localNewsContent.text = newsContent
        self.title = "news".localized(lang: self.lang)!
//        self.navigationController?.navigationBar.topItem?.title = ""
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "news".localized(lang: self.lang)!

    }
    
    func setupSlideShow() {
        var imageArray = [InputSource]()
        var count = 0
        for imageModel in (images?.array)! {
            guard  let url = URL(string: imageModel.link) else {
                return
            }
            imageArray.append(KingfisherSource(url: url))
            
            count += 1
        }
        localNewsSlideShow.setImageInputs(imageArray)
        localNewsSlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        localNewsSlideShow.pageControl.currentPageIndicatorTintColor = .red
    }
}
