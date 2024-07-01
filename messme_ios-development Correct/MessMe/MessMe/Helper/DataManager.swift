//
//  DataManager.swift
//  MarketPlace
//
//  Created by Logictrix-3 on 04/10/21.
//

import UIKit

class DataManager {
    
    static var deviceId:String? {
            set {
                UserDefaults.standard.setValue(newValue, forKey: "DeviceTokenFCM")
                UserDefaults.standard.synchronize()
            }
            get {
                return UserDefaults.standard.string(forKey: "DeviceTokenFCM")
            }
        }

    static var UserId:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: userId)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: userId)
        }
        
    }
    
    static var Language:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: languag)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: languag)
        }
        
    }
    
    static var Email:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserEmail)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: UserEmail)
        }
        
    }
    
    static var Name:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: Username)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: Username)
        }
    }
    
    static var Password:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: PassWord)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: PassWord)
        }
    }
    
    static var Id:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: Warningid)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: Warningid)
        }
        
    }
    
    
    static var Phonenumber:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: PhoneNumber)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: PhoneNumber)
        }
    }
    
    
    static var countryCode:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: contryCode)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: contryCode)
        }
    }
    
    
    static var countryImg:Data? {
           set {
               UserDefaults.standard.setValue(newValue, forKey: contryImg)
               UserDefaults.standard.synchronize()
           }
           get {
               return UserDefaults.standard.data(forKey: contryImg)
           }
       }
    
    
    static var isLogin:Bool? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: isloginn)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: isloginn)
        }
    }
    
    static var tokenId:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: fcmRegToken)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: fcmRegToken)
        }
    }
    
}
