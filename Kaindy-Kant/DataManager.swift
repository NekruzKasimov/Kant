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
    var userId: Int?
    var uDefaults = UserDefaults.standard
    func saveUser(username: String, password: String) {
        uDefaults.set(username, forKey: "username")
        uDefaults.set(password, forKey: "password")
    }
    func getUser() -> [String: String]? {
        guard let username = uDefaults.string(forKey: "username"), let password = uDefaults.string(forKey: "password") else {
            return nil
        }
        return ["username": username, "password": password]
    }
    func clearData(){
        uDefaults.removeObject(forKey: "username")
        uDefaults.removeObject(forKey: "password")
        uDefaults.removeObject(forKey: "token")
    }
    func setUserId(user_id: Int) {
        self.userId = user_id
    }
    func getUserId() -> Int {
        return userId!
    }
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
