//
//  Weather.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON


class Weather {
    var list: Lists
    
    init(json: JSON) {
        list = Lists(json: json["list"])
    }
}

struct List {
    var date: Date
    var main: Main
    var weatherStatuses: WeatherStatuses
    
    init(json: JSON) {
        date = json["dt"].intValue.timestampToDate()
        main = Main(json: json["main"])
        weatherStatuses = WeatherStatuses(json: json["weather"])
    }
}

class Lists: NSObject {
    var array: Array = Array<List>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = List(json:json)
            array.append(tempObject)
        }
    }
}

class Main {
    var temp: Float
    
    init(json: JSON) {
        temp = json["temp"].floatValue - 273
    }
}

class WeatherStatus {
    var main: String
    var description: String
    
    init (json: JSON) {
        main = json["main"].stringValue
        description = json["description"].stringValue
    }
}

class WeatherStatuses: NSObject {
    var array: Array = Array<WeatherStatus>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = WeatherStatus(json:json)
            array.append(tempObject)
        }
    }
}
