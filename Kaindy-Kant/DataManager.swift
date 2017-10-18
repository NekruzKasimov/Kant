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
    func saveUserInformation(userDictionary: [String: String]){
        uDefaults.set(userDictionary, forKey: "user_information")
    }
    func getUserInformation() -> [String: String]? {
        guard let user_information = uDefaults.object(forKey: "user_information") else {
            return nil
        }
        return user_information as! [String : String]
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
        uDefaults.removeObject(forKey: "user_information")

    }
    func setUserId(user_id: Int) {
        self.userId = user_id
    }
    func getUserId() -> Int {
        return userId == nil ? 0 : userId!
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
