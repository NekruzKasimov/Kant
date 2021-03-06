//
//  Constants.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

struct Constants {
    
    static var lang: String?
    
    static var shared: Constants {
        struct Static {
            static let instance = Constants()
        }
        return Static.instance
    }
    
    func setLanguage() {
        Constants.lang = DataManager.shared.getLanguage()
        _ = MainPage.init()
        _ = MenuPage.init()
        _ = Values.init()
        _ = SugarAndJom.init()
        _ = Weather.init()
        _ = Network.ErrorMessage.init()
    }

    
    struct Network {
        
        struct ErrorMessage {
            static var NO_INTERNET_CONNECTION = "no_internet_connection".localized(lang: "ru")
            static var UNABLE_LOAD_DATA = "unable_load_data".localized(lang: "ru")
            static let NO_HTTP_STATUS_CODE = "Unable to get response HTTP status code"
            static var UNAUTHORIZED = "unauthorized".localized(lang: "ru")
            
            init() {
                Network.ErrorMessage.NO_INTERNET_CONNECTION = "no_internet_connection".localized(lang: lang!)
                Network.ErrorMessage.UNABLE_LOAD_DATA = "unable_load_data".localized(lang: lang!)
                Network.ErrorMessage.UNAUTHORIZED = "unauthorized".localized(lang: lang!)
            }
        }
        
        struct EndPoints {
            static let Token_auth = "api/token-auth"
            static let Login = "api/user/login"
            static let UpdateUser = "api/user"
            static let SignUp = "api/user/signup"
            static let FinOffice = "api/fin-office"
            static let NewRossahar = "api/news/rossahar?limit=50&offset=0"
            static let LocalNews = "api/news/domestic?limit=50&offset=0"
            static let Expenses = "api/expenses"
            static let SugarJom = "api/sugar-jom"
            static let Currencies = "api/currency"
            static let Weather = "api/weather"
            static let GetUser = "api/user"
            static let GetFields = "api/field"
            static let GetServices = "api/service"
            static let GetTechnologies = "api/technology"
            static let GetSuppliers = "api/supplier"
            static let FieldExpenses = "api/expenses"
            static let BeetPoint = "api/beet-point"
            static let ChangePassword = "api/user/change-password"
            static let RegisterToken = "api/user/register-token"

        }
    }
    
    struct SugarAndJom {
        static var JomDate: String?
        static var SugarDate: String?
        init(){
            SugarAndJom.SugarDate = "sugar_tax".localized(lang: lang!)
            SugarAndJom.JomDate = "jom_tax".localized(lang: lang!)
        }
    }
    
    struct Weather {
        static var months = [String]()
        static var weekdays = [String]()
        static var weatherStatuses = [String: String]()
        init () {
            Weather.weekdays = ["sunday".localized(lang: lang!)!, "monday".localized(lang: lang!)!, "tuesday".localized(lang: lang!)!, "wednesday".localized(lang: lang!)!, "thursday".localized(lang: lang!)!, "friday".localized(lang: lang!)!, "saturday".localized(lang: lang!)!]
            Weather.weatherStatuses = ["Cloudy" : "cloudy".localized(lang: lang!)!, "Clear" : "sunny".localized(lang: lang!)!, "Rain" : "rainy".localized(lang: lang!)!, "Snow" : "snowy".localized(lang: lang!)!]
            Weather.months = ["january".localized(lang: lang!)!, "february".localized(lang: lang!)!, "march".localized(lang: lang!)!, "april".localized(lang: lang!)!, "may".localized(lang: lang!)!, "june".localized(lang: lang!)!, "july".localized(lang: lang!)!, "august".localized(lang: lang!)!, "september".localized(lang: lang!)!, "october".localized(lang: lang!)!, "november".localized(lang: lang!)!, "december".localized(lang: lang!)!]
        }
    }
    
    struct MainPage {
        static var technology: String?
        static var myFields: String?
        init(){
            MainPage.technology = "technology".localized(lang: lang!)
            MainPage.myFields = "my_field".localized(lang: lang!)
        }
    }
    
    struct MenuPage {
        static let menu = ["main_menu", "my_field" , "news", "services", "suppliers", "budget", "contracts", "settings", "logout"]
        static let navigations = ["MainNav" , "FieldsNav", "NewsNav" , "ServiceNav" , "ProviderNav" , "CalcNav", "ContractsNav", "SettingsNav" , "LoginNav"]
        static let storyboards = ["Main" , "Profile", "News" , "Service" , "Provider" , "CalculatorExcelViewController", "Contracts","Settings" ,  "Login"]
    }
    struct Values {
        static var error: String?
        static var cancel: String?
        static var chooseImage: String?
        static var save: String?
        static var changePassword: String?
        init() {
            Values.error = "error1".localized(lang: lang!)
            Values.cancel = "cancel".localized(lang: lang!)
            Values.chooseImage = "choose_image".localized(lang: lang!)
            Values.save = "save_changes".localized(lang: lang!)
            Values.changePassword = "change_password".localized(lang: lang!)
        }
    }

}

