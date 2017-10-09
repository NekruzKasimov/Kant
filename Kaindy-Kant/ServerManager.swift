//
//  ServerManager.swift
//  OpenSport
//
//  Created by Sanira on 12/3/16.
//  Copyright © 2016 TimelySoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerManager: HTTPRequestManager  {
    
    var _rossahar: Rossahar?
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    
    func getWeather(_ completion: @escaping (Weather)-> Void, error: @escaping (String)-> Void) {
        print("here")
        self.get(api: "&APPID=079587841f01c6b277a82c1c7788a6c3", completion: { (json) in
                    let obj = Weather(json: json)
                    completion(obj)
                }, error: error)
    }
    
//    func getNewsRossahar(_ completion: @escaping (Rossahar)-> Void, error: @escaping (String)-> Void)
//    {
//        self.get(api: "", completion: <#T##HTTPRequestManager.SuccessHandler##HTTPRequestManager.SuccessHandler##(JSON) -> Void#>, error: <#T##HTTPRequestManager.FailureHandler##HTTPRequestManager.FailureHandler##(String) -> Void#>)
//    }
//    func getContactTypes(_ completion: @escaping (ContactTypes)-> Void, error: @escaping (String)-> Void) {
//
//        if _contactTypes != nil {
//            completion(_contactTypes!)
//            return
//        }
//
//        self.get(api: "getAllContactTypes", completion: { (json) in
//            let obj = ContactTypes(json: json)
//            self._contactTypes = obj
//            completion(obj)
//        }, error: error)
//    }
//
//    func getCoursesByCategory(categoryName: String,_ completion: @escaping (SimplifiedCourses)-> Void, error: @escaping (String)-> Void) {
//        if _categoryName != nil {
//            completion(_categoryName!)
//            return
//        }
//
//        self.get(api: "getCoursesByCategory/\(categoryName)", completion: {(json) in
//            let obj = SimplifiedCourses(json: json)
//            self._categoryName = obj
//            completion(obj)
//        }, error:error)
//    }
//
//    func getCoursesBySubCategory(subCategoryName: String,_ completion: @escaping (SimplifiedCourses)-> Void, error: @escaping (String)-> Void) {
//        if _subCategoryName != nil {
//            completion(_subCategoryName!)
//            return
//        }
//        self.get(api: "getCoursesBySubcategory/\(subCategoryName)", completion: {(json) in
//            let obj = SimplifiedCourses(json: json)
//            self._subCategoryName = obj
//            completion(obj)
//        }, error:error)
//
//    }
//
//    func getCategories(_ completion: @escaping (Categories)-> Void, error: @escaping (String)-> Void) {
//        if _categories != nil {
//            completion(_categories!)
//            return
//        }
//        self.get(api: "getAllCategories", completion: { (json) in
//            let obj = Categories(json: json)
//            self._categories = obj
//            completion(obj)
//        }, error: error)
//    }
//
//    func getBranches(_ completion: @escaping (Branches)-> Void, error: @escaping (String)-> Void) {
//
//        if _branches != nil {
//            completion(_branches!)
//            return
//        }
//        self.get(api: "getAllBranches", completion: { (json) in
//            let obj = Branches(json: json)
//            self._branches = obj
//            completion(obj)
//        }, error: error)
//    }
//
//    func getAllSimplifiedCourses(_ completion: @escaping (SimplifiedCourses)-> Void, error: @escaping (String)-> Void) {
//
//        if _simplifiedCourses != nil {
//            completion(_simplifiedCourses!)
//            return
//        }
//        self.get(api: "getAllCourses", completion: { (json) in
//            let obj = SimplifiedCourses(json: json)
//            self._simplifiedCourses = obj
//            completion(obj)
//        }, error: error)
//    }
//
//    func getAllCourses(_ completion: @escaping (Courses)-> Void, error: @escaping (String)-> Void) {
//
//        if _courses != nil {
//            completion(_courses!)
//            return
//        }
//        self.get(api: "getAllCourses", completion: { (json) in
//            let obj = Courses(json: json)
//            self._courses = obj
//            completion(obj)
//        }, error: error)
//    }
//
//    func getCoursesByCategoryAndSubCategory(categoryName: String,subCategoryName: String, _ completion: @escaping (SimplifiedCourses)-> Void, error: @escaping (String)-> Void) {
//
//        let api = "getCoursesByBoth/\(categoryName)/\(subCategoryName)"
//        self.get(api: api, completion: { (json) in
//            let obj = SimplifiedCourses(json: json)
//            completion(obj)
//        }, error: error)
//    }
//
//    func getCourseByName(courseName: String,_ completion: @escaping (Course)-> Void, error: @escaping (String)-> Void) {
//
//        if _course != nil {
//            completion(_course!)
//            return
//        }
//
//        let api = "getCourseByName/\(courseName)"
//
//        self.get(api: api, completion: { (json) in
//            let obj = Course(json: json)
//            self._course = obj
//            completion(obj)
//        }, error: error)
//    }
//
//    func addCourse(course: Course, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
//        let param = course.toDict()
//
//        post(api: "addCourse",
//             parameters: param, completion: {(json) in
//            self._simplifiedCourses = nil
//            completion()
//            }
//        , error: error)
//    }
//
//    func addCategory(category: Category, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
//        let param = category.toDict()
//
//        post(api: "addCategory",
//             parameters: param, completion: {(json) in
//                self._categories = nil
//                completion()
//        }
//            , error: error)
//    }
//
//    func addSubCategories(category: Category, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
//        let param = category.toDict()
//
//        post(api: "addSubCategories",
//             parameters: param, completion: {(json) in
//                self._categories = nil
//                completion()
//        }
//            , error: error)
//    }
//
//    func deleteMethod(index: Int,type: String, name: String, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
//        var api = ""
//        switch type {
//        case "category":
//           _categories = nil
//            api = "deleteCategory"
//        default:
//            _simplifiedCourses = nil
//            api = "deleteCourse"
//        }
//        delete(api: "\(api)/\(name)",
//            parameters: [:], completion: {(json) in
//                completion()
//        }
//        , error: error)
//    }
//
//    func deleteSubCategory(name: String, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
//        let api = "deleteSubCategory"
//        _categories = nil
//        delete(api: "\(api)/\(name)",
//            parameters: [:], completion: {(json) in
//                completion()
//        }
//            , error: error)
//    }
}
