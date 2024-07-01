//
//  L102Language.swift
//  MessMe
//
//  Created by Prashant Sharma on 24/06/22.
//

import Foundation
import UIKit

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class L102Language: NSObject {
    
    // get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
//        print("current ",current)
        return current
    }
    
    // set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }

}
