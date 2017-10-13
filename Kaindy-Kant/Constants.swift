//
//  Constants.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

struct Constants {
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
            static let SignUp = "api/user/signup"
            static let FinOffice = "api/fin-office"
            static let NewRossahar = "api/news/rossahar?limit=100&offset=0"
            static let Expenses = "api/expenses"
            static let SugarJom = "api/sugar-jom"
            static let Currencies = "api/currency"
            static let Weather = "api/weather"
        }
    }
    
    struct SugarAndJom {
        static let JomDate = "Сушенный гранулированный жом НТБ (руб./т, с НДС)"
        static let SugarDate = "Расчетная цена на сахар НТБ (руб./т, с НДС)"
    }
}

