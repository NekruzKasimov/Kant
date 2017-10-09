//
//  NewUser.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON


class NewUser {
    var first_name: String
    var last_name: String
    var phone: String
    var email: String
    var fathers_name: String
    var password: String
    var password_repeat: String
    var date_of_birth: String
    var address: String
    var city: String
    var photo: String
    init() {
        self.first_name = ""
        self.last_name = ""
        self.phone = ""
        self.email = ""
        self.fathers_name = ""
        self.password = ""
        self.password_repeat = ""
        self.address = ""
        self.date_of_birth = ""
        self.city = ""
        self.photo = ""
    }
    init(json: JSON) {
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.phone = json["phone"].stringValue
        self.email = json["email"].stringValue
        self.fathers_name = json["fathers_name"].stringValue
        self.password = json["password"].stringValue
        self.password_repeat = json["password_repeat"].stringValue
        self.address = json["address"].stringValue
        self.city = json["city"].stringValue
        self.photo = json["photo"].stringValue
        self.date_of_birth = json["date_of_birth"].stringValue
    }
    func toDictionary() -> [String: Any]{
        return ["first_name": self.first_name,
                "last_name": self.last_name,
                "phone": self.phone,
                "email": self.email,
                "fathers_name": self.fathers_name,
                "password": self.password,
                "password_repeat": self.password_repeat,
                "address": self.address,
                "city": self.city,
                "photo": self.photo,
                "date_of_birth": self.date_of_birth]
    }
}
