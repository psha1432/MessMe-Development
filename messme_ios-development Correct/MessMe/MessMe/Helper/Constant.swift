//
//  Constant.swift
//  Tari
//
//  Created by Logictrix-iOS-5 on 07/12/20.
//  Copyright © 2020 logictix. All rights reserved.
//

import Foundation
import UIKit

let appName = "MessMe"

let whitePolyGonImg = UIImage(named: "Polygon 3")
let pinkPolyGonImg = UIImage(named: "Polygon 7")
let optionAlert = "Please select an option"
let Ok = "OK"


let tabValue = "tabValue"
let user_Id = "user_Id"
let partner_Id = "0"
let educatorPartner_id = "0"
let partner_LoginManage = "partner_LoginManage"
let user_Login = "user_Login"
let Partner_Login  = "Partner_Login"
let mentor_Login = "mentor_Login"
let firstLogin = "firstLogin"
let technologyStatus = "technologyStatus"
let loginStatus = "loginStatus"
let userId = "userId"
let languag = "languag"
let isloginn = "isloginn"
let Warningid = "Warningid"
let UserEmail = "UserEmail"
let PhoneNumber = "PhoneNumber"
let Username = "Username"
let PassWord = "PassWord"
let contryCode = "contryCode"
let contryImg = "contryImg"
let fcmRegToken = "fcmRegToken"

extension NSAttributedString {
    
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }
        
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString: attributedString)
    }
}
extension String {
    public func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
  
        func htmlAttributedString() -> NSAttributedString? {
            guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
            guard let html = try? NSMutableAttributedString(data: data, options:  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return nil }
            return html
        }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf16) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf16.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    
    
}
