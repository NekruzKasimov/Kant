//
//  DetailedServiceViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 18.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class DetailedServiceViewController: UIViewController {
    
    @IBOutlet weak var numberTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        
            let phoneNumber = "+32514325"
            let alert = UIAlertController(title: phoneNumber, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (alert) in
                if UIApplication.shared.canOpenURL(URL as URL) {
                    UIApplication.shared.openURL(URL as URL)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                print("User Canceld")
            }))
            present(alert, animated: true, completion: nil)
            return false
    }
}
