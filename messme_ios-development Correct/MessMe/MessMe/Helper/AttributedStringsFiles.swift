//
//  AttributedStringsFiles.swift
//  Fetuu
//
//  Created by Logictrix on 04/08/21.
//  Copyright © 2021 Logictrix. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class AttributedStringsFiles {
    
    

    static var optionHeadTitle:NSMutableAttributedString {
        
        let fullString = NSMutableAttributedString(string: "Select", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 27)])
        
        fullString.append(NSAttributedString(string: " ALL ", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red: 220/255, green: 90/255, blue: 113/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 27)]))
        
        fullString.append(NSAttributedString(string: "that applies", attributes:[NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 27)]))

        return fullString
    }
    //        I'm available in 14 days.
    //        I'm available to mentor now.
    static var mentorNow:NSMutableAttributedString {
        
        let fullString = NSMutableAttributedString(string: "I'm available to mentor", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 19/255, green: 15/255, blue: 64/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19)])
        
        fullString.append(NSAttributedString(string: " now.", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red: 19/255, green: 15/255, blue: 64/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 19)]))
        
        return fullString
    }
    static var availableNow:NSMutableAttributedString {
        
        let fullString = NSMutableAttributedString(string: "I'm available", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 19/255, green: 15/255, blue: 64/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19)])
        
        fullString.append(NSAttributedString(string: " in 14 days. ", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red: 19/255, green: 15/255, blue: 64/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 19)]))
        
     
        
        return fullString
    }

}
