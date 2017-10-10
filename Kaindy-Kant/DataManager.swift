//
//  DataManager.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    
    class var shared: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
    var newUser: NewUser?
    var newRossahar: Rossahar?
    
    func setNewUser(newUser: NewUser) {
        self.newUser = newUser
    }
    func getNewUser() -> NewUser {
        return newUser!
    }
    func getNewRossahar() -> Rossahar {
        return newRossahar!
    }
}
