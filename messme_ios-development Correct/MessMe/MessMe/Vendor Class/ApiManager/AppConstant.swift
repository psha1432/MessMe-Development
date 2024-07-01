
//
//  AppConstant.swift
//  B24
//
//  Created by Varun Naharia on 21/08/17.
//  Copyright © 2017 Logictrixtech. All rights reserved.
//


import Foundation
import UIKit


class AppConstant {

struct AppURL {
    
    #if DEVELOPMENT
        static let BaseURL = "http://44.204.61.114:8086/api/"
    #else
        static let BaseURL = "http://44.204.61.114:8086/api/"
    #endif
        
    static let Register = "Register"
    static let Login = "Login"
    static let AddWarning = "AddWarning"
    static let GetMyWarningList = "GetMyWarningList"
    static let GetMyWarningDetailsById = "GetMyWarningDetailsById"
    static let ForgotPassword = "ForgotPassword"
    static let PaypalPayment = "PaypalPayment"
    
   }

}
