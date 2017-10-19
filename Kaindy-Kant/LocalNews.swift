//
//  LocalNews.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 18.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LocalNews {
    var title: String
    var description: String
    var content: String
    
    init(json: JSON) {
        title = json["name"].stringValue
        description = json["description"].stringValue
        content = json["content"].stringValue
    }
}

class LocalNewses: NSObject {
    override init() {}
    var array: Array = Array<LocalNews>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = LocalNews(json:json)
            array.append(tempObject)
        }
    }
}

struct News {
    var results: LocalNewses
    
    init(json: JSON) {
        results = LocalNewses(json: json["results"])
    }
    func getLocalNews() -> [String: Any] {
        return ["results": results]
    }
}
class Newses: NSObject {
    override init() {}
    var array: Array = Array<News>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = News(json:json)
            array.append(tempObject)
        }
    }
}
