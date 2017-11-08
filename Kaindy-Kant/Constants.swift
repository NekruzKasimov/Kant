//
//  Constants.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

struct Constants {
    
    static let lang = DataManager.shared.getLanguage()
    
    struct Network {
        
        struct ErrorMessage {
            static let NO_INTERNET_CONNECTION = "No internet connection"
            static let UNABLE_LOAD_DATA = "Unable load data"
            static let NO_HTTP_STATUS_CODE = "Unable to get response HTTP status code"
            static let UNAUTHORIZED = "Unauthorized error"
        }
        
        struct EndPoints {
            static let Token_auth = "api/token-auth"
            static let Login = "api/user/login"
            static let UpdateUser = "api/user"
            static let SignUp = "api/user/signup"
            static let FinOffice = "api/fin-office"
            static let NewRossahar = "api/news/rossahar?limit=100&offset=0"
            static let LocalNews = "api/news/domestic?limit=100&offset=0"
            static let Expenses = "api/expenses"
            static let SugarJom = "api/sugar-jom"
            static let Currencies = "api/currency"
            static let Weather = "api/weather"
            static let GetUser = "api/user"
            static let GetFields = "api/field"
            static let GetServices = "api/service"
            static let GetTechnologies = "api/technology"
            static let GetSuppliers = "api/supplier"
            static let FieldExpenses = "api/expenses/field"
        }
    }
    
    struct SugarAndJom {
        static let JomDate = "Сушенный гранулированный жом НТБ (руб./т, с НДС)"
        static let SugarDate = "Расчетная цена на сахар НТБ (руб./т, с НДС)"
    }
    
    struct Weather {
        static let months = ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]
        static let weekdays = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
        static let weatherStatuses = ["Clouds" : "Пасмурно", "Clear" : "Ясное небо", "Rain" : "Дожди", "Snow" : "Снег"]
    }
    
    struct MainPage {
        static let technology = "technology".localized(lang: lang)
        static let myFields = "my_field".localized(lang: lang)
    }
    
    struct MenuPage {
        static let menu = ["main_menu".localized(lang: lang) , "my_field".localized(lang: lang) , "news".localized(lang: lang) , "services".localized(lang: lang) , "suppliers".localized(lang: lang) , "budget".localized(lang: lang) , "about_app".localized(lang: lang) ,  "logout".localized(lang: lang)]
        static let navigations = ["MainNav" , "FieldsNav", "NewsNav" , "ServiceNav" , "ProviderNav" , "CalcNav", "AboutAppNav" , "LoginNav"]
        static let storyboards = ["Main" , "Profile", "News" , "Service" , "Provider" , "CalculatorExcelViewController", "AboutApp" ,  "Login"]
    }
    
    struct Values {
        static let error = "error1".localized(lang: lang)
        static let cancel = "cancel".localized(lang: lang)
        static let chooseImage = "choose_image".localized(lang: lang)
        static let save = "save".localized(lang: lang)
        static let changePassword = "change_password".localized(lang: lang)
    }
}

