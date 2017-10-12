//
//  DescriptionViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class DescriptionViewController: UIViewController {
    var desc: String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var webSite: String?
    
    @IBOutlet weak var showWebSiteButton: UIButton! {
        didSet {
            showWebSiteButton.accessibilityIdentifier = "showWebSiteButton"
            let attrs:[String : Any] = [
                NSFontAttributeName : UIFont.systemFont(ofSize: 24.0),
                NSForegroundColorAttributeName : UIColor.init(netHex: Colors.purple),
                NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue
            ]
            let attributeString = NSMutableAttributedString(string: "Перейти на сайт банк",
                                                            attributes: attrs)
            showWebSiteButton.setAttributedTitle(attributeString, for: .normal)
            showWebSiteButton.addTarget(self, action: #selector(showWebSite), for: .touchUpInside)
        }
    }
    
    func showWebSite(){
        if (webSite?.contains("http"))! {
            UIApplication.shared.openURL(URL(string: webSite!)!)
        } else {
            UIApplication.shared.openURL(URL(string: "http://" + webSite!)!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descriptionLabel.text = desc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if webSite != nil {
             showWebSiteButton.isHidden = false
        } else {
            showWebSiteButton.isHidden = true
        }
    }
}

//MARK SJSegmentViewController

extension DescriptionViewController: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return scrollView
    }
}


