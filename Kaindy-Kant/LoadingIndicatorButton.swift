//
//  LoadingIndicatorButton.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import FontAwesome_swift

class LoadingIndicatorButton: UIButton {
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var buttonTitle: String?
    var bc:UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        confgureIndicator()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        confgureIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func confgureIndicator(){
        activityIndicator = UIActivityIndicatorView(frame:CGRect(origin: .zero, size: CGSize(width: 24, height: 24)))
        activityIndicator.activityIndicatorViewStyle = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        let xConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([xConstraint, yConstraint])
    }
    private func configureButton(){
        self.backgroundColor = bc ?? UIColor(netHex: Colors.green)
        self.layer.cornerRadius = 15
        self.setTitleColor(.white, for: .normal)
        self.setTitle(buttonTitle, for: .normal)
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: 18)
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        self.setTitle(buttonTitle, for: .normal)
        self.isEnabled = true
    }
    
    func startActivity() {
        activityIndicator.startAnimating()
        self.isEnabled = false
        self.setTitle("", for: .normal)
    }
}
