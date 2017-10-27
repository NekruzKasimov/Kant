//
//  GlobalFunctions.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

/**
 Configure common UI elements
 */

struct GlobalFunctions {
    static func configureRigthView (in textField: UITextField, image:UIImage, action: Selector) {
        let button = UIButton(frame: CGRect(x: 0, y: 0,
                                            width: textField.bounds.height,
                                            height: textField.bounds.height))
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: -8, right: 0)
        button.addTarget(nil, action: action, for: UIControlEvents.touchUpInside)
        button.setImage(image, for: .normal)
        textField.rightViewMode = .always
        textField.rightView = button
    }
    static func configure(textField: SkyFloatingLabelTextField, withText text:String, placeholder:String, tag:Int){
        textField.autocorrectionType = .no
        textField.font = UIFont(name: ".SFUIText", size: 15)
        textField.returnKeyType = .done
        textField.placeholder = placeholder
        textField.title = text
        textField.selectedTitleColor = UIColor.init(netHex: Colors.yellow)
        textField.selectedLineColor = UIColor.init(netHex: Colors.yellow)
        textField.tag = tag
    }
    
    static func configureLeftView(in textField: UITextField, tag: Int, placeholderText: String, withLineView lineView: UIView, labelWidth: Int, labelText: String) {
        let placeholdercColor = UIColor.init(netHex: 0xC7C7CD)
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes:[NSForegroundColorAttributeName:placeholdercColor])
        lineView.backgroundColor = UIColor(netHex: Colors.gray)
        
        textField.addSubview(lineView)
        textField.tag = tag
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: Int(textField.bounds.height)))
        label.text = labelText
        label.font = UIFont(name: ".SFUIText", size: 16)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = label
    }
}






