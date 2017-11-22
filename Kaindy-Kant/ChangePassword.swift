//
//  ChangePassword.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ChangePassword {
    var old_password: String
    var new_password: String
    var new_password_repeat: String


    func getDictionary() -> [String: Any]{
        return ["old_password": old_password, "new_password": new_password, "new_password_repeat": new_password_repeat]
    }
}

