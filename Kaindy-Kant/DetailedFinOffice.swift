//
//  DetailedFinOffice.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailedFinOffice {
    var id: Int
    var title: String
    var logo: String
    var description: String
    var branches: Branches?
    var contacts: Contacts?
    var images: Images?
    
    init(json: JSON){
        id = json["id"].intValue
        title = json["title"].stringValue
        logo = json["logo"].stringValue
        description = json["description"].stringValue
        branches = Branches(json: json["branches"])
        contacts = Contacts(json: json["contacts"])
        images = Images(json: json["images"])
    }
}


class Branch {
    var id: Int
    var name: String
    var address: String
    var phone: String
    var longitude: String
    var latitude: String
   
    init(json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        address = json["address"].stringValue
        phone = json["phone"].stringValue
        longitude = json["longitude"].stringValue
        latitude = json["latitude"].stringValue
    }
}


class Branches: NSObject {
    var array: Array = Array<Branch>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Branch(json:json)
            array.append(tempObject)
        }
    }
}


class Contact {
    var id: Int
    var type: String
    var data: String
    init(json: JSON){
        id = json["id"].intValue
        type = json["type"].stringValue
        data = json["data"].stringValue
    }
}


class Contacts: NSObject {
    var array: Array = Array<Contact>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Contact(json:json)
            array.append(tempObject)
        }
    }
}


class Image {
    var id: Int
    var image: String
    init(json: JSON){
        id = json["id"].intValue
        image = json["image"].stringValue
    }
}


class Images: NSObject {
    var array: Array = Array<Image>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Image(json:json)
            array.append(tempObject)
        }
    }
}

struct Location {
    var latitude: Double
    var longitude: Double
    
    init(latitude: String, longitude: String) {
        self.latitude = Double(latitude)!
        self.longitude = Double(longitude)!
    }
    
    func toDict() -> [String: Any]
    {
        return ["longitude": longitude,
                "latitude": latitude]
    }
}
