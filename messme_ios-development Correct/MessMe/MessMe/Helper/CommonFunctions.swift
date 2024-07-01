
//  CommonFunctions.swift
//  Wippi_iOS
//
//  Created by Logictrix-iOS-5 on 04/08/20.
//  Copyright © 2020 Logictrix. All rights reserved.


import UIKit
import MBProgressHUD

class CommonFunctions: NSObject {
    
    static var isfirstLogin:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: firstLogin)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: firstLogin)
        }
    }
    
    static var istabValue:String?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: tabValue)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: tabValue)
        }
    }
    
    static var isUser_id:Int?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: user_Id)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: user_Id)
        }
    }
    static var isPartner_id:Int?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: partner_Id)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: partner_Id)
        }
    }
    static var isEducatorPartner_id:Int?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: educatorPartner_id)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: educatorPartner_id)
        }
    }
    static var isPartner_LoginManage:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: partner_LoginManage)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: partner_LoginManage)
        }
    }
    static var isUser_Login:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: user_Login)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: user_Login)
        }
    }
    static var isPartner_Login:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: Partner_Login)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: Partner_Login)
        }
    }
    
    static var isMentor_Login:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: mentor_Login)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: mentor_Login)
        }
    }
    static var istechnologyStatus:String?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: technologyStatus)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: technologyStatus)
        }
    }
    static var isloginStatus:String?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: loginStatus)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: loginStatus)
        }
    }
    
    
    
    //MARK: - Show alert
    class func showAlert (_ reference:UIViewController, message:String, title:String){
        var alert = UIAlertController()
        if title == "" {
            alert = UIAlertController(title: nil, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        else{
            alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        
        alert.addAction(UIAlertAction(title: Ok, style: UIAlertAction.Style.default, handler: nil))
        reference.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - ProgressIndicator view start
    class func startProgressView(view:UIView){
        // let commonView:UIView = (self.window?.rootViewController?.view!)!
        let spinnerActivity = MBProgressHUD.showAdded(to: view, animated: true);
        spinnerActivity.mode = MBProgressHUDMode.indeterminate
        spinnerActivity.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    //MARK: - ProgressIndicator View Stop
    class func dismissProgressView(view:UIView)  {
        // let commonView:UIView = (self.window?.rootViewController?.view!)!
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    
    //MARK:- Update Langauge Strings
//    class func updateLangugaeStrings() {
//        
//        CAVCAlrt1_LS = NSLocalizedString("LS_01", comment: "Please Enter Phone Number")
//        
//        CAVCAlrt2_LS = NSLocalizedString("LS_02", comment: "Number Should Not Be Less Then 8 Digit")
//        
//        CAVCAlrt3_LS = NSLocalizedString("LS_03", comment: "Please Fill Country Code")
//        
//        CAVCAlrt4_LS = NSLocalizedString("LS_04", comment: "Please Enter Password")
//        
//        CAVCAlrt5_LS = NSLocalizedString("LS_05", comment: "Enter 8 Digit Password")
//        
//        CAVCAlrt6_LS = NSLocalizedString("LS_06", comment: "Please Enter Confirm Password")
//        
//        CAVCAlrt7_LS = NSLocalizedString("LS_07", comment: "Password and Confirm Password is not matched.")
//        
//        CAVCAlrt8_LS = NSLocalizedString("LS_08", comment: "Please Enter Email")
//        
//        CAVCAlrt9_LS = NSLocalizedString("LS_09", comment: "Enter Proper Email")
//        
//        CAVCAlrt10_LS = NSLocalizedString("LS_10", comment: "Please Enter DOB")
//        
//        CAVCAlrt11_LS = NSLocalizedString("LS_11", comment: "Please Enter Valid DOB Date")
//        
//        CAVCAlrt12_LS = NSLocalizedString("LS_12", comment: "Select Your Gender")
//        
//        CAVCAlrt13_LS = NSLocalizedString("LS_13", comment: "Please Enter First Name")
//        
//         LVCAlrt01_LS = NSLocalizedString("LS_14", comment: "Please Enter Phone Number")
//        
//        LVCAlrt02_LS = NSLocalizedString("LS_15", comment: "Please Enter Country Code")
//        
//        LVCAlrt03_LS = NSLocalizedString("LS_16", comment: "Please Enter your Password")
//        
//        MPVAlrt01_LS = NSLocalizedString("LS_17", comment: "Please Enter Date of Expiration")
//        
//        MPVAlrt02_LS = NSLocalizedString("LS_18", comment: "Enter Valid Date")
//        
//        MPVAlrt03_LS = NSLocalizedString("LS_19", comment: "Please Enter Instance")
//        
//        MPVAlrt04_LS = NSLocalizedString("LS_20", comment: "Please Enter Warning Detail")
//        
//        CNWCAlrt01_LS = NSLocalizedString("LS_21", comment: "Please Enter Warning Name")
//        
//         CNWCAlrt02_LS = NSLocalizedString("LS_22", comment: "Please Enter Date of Expiration")
//        
//        CNWCAlrt03_LS = NSLocalizedString("LS_23", comment: "Enter Valid Expiry Date")
//        
//         CNWCAlrt04_LS = NSLocalizedString("LS_24", comment: "Please Enter Instance")
//        
//         CNWCAlrt05_LS = NSLocalizedString("LS_25", comment: "Please Enter Instance")
//        
//         CNWCAlrt06_LS = NSLocalizedString("LS_26", comment: "Please Enter Warning Detail")
//        
//         CNWCAlrt07_LS = NSLocalizedString("LS_27", comment: "Please Enter Warning Detail")
//        
//         CNWCAlrt08_LS = NSLocalizedString("LS_28", comment: "Please Select Warning Type")
//        
//        CNWCAlrt09_LS = NSLocalizedString("LS_29", comment: "Please Enter Warning Date")
//        
//        CNWCAlrt10_LS = NSLocalizedString("LS_30", comment: "Enter One Time Valid Date")
//        
//        CNWCAlrt11_LS = NSLocalizedString("LS_31", comment: "Please Enter OneTime")
//        
//        CNWCAlrt12_LS = NSLocalizedString("LS_32", comment: "Choose Alert Channel")
//        
//        CNWCAlrt13_LS = NSLocalizedString("LS_33", comment: "Choose Payment Channel")
//        
//        CNWCAlrt14_LS = NSLocalizedString("LS_34", comment: "Please Enter Alert 1 Date")
//        
//        CNWCAlrt15_LS = NSLocalizedString("LS_35", comment: "Please Enter Alert 1 Valid Date")
//        
//        CNWCAlrt16_LS = NSLocalizedString("LS_36", comment: "Please Enter Alert 1 Time")
//        
//        CNWCAlrt17_LS = NSLocalizedString("LS_37", comment: "Please Enter Alert 2 Date")
//        
//        CNWCAlrt18_LS = NSLocalizedString("LS_38", comment: "Please Enter Alert 2 Valid Date")
//        
//        CNWCAlrt19_LS = NSLocalizedString("LS_39", comment: "Please Enter Alert 2 Time")
//        
//        CNWCAlrt20_LS = NSLocalizedString("LS_40", comment: "Please Enter Alert 3 Date")
//        
//        CNWCAlrt21_LS = NSLocalizedString("LS_41", comment: "Please Enter Alert 3 Valid Date")
//        
//        CNWCAlrt22_LS = NSLocalizedString("LS_42", comment: "Please Enter Alert 3 Time")
//        
//         CNWCAlrt23_LS = NSLocalizedString("LS_43", comment: "Choose Alert Channel")
//        
//         CNWCAlrt24_LS = NSLocalizedString("LS_44", comment: "Choose Payment Channel")
//        
//        PPVCAlrt1_LS = NSLocalizedString("LS_45", comment: "Please Enter Amount")
//        
//        EPVCAlrt1_LS = NSLocalizedString("LS_46", comment: "Please Enter Name")
//        
//        DoneButtonAlrt_LS = NSLocalizedString("LS_47", comment: "Done")
//
//        CNWCAlrt25_LS = NSLocalizedString("LS_48", comment: "Please Enter Future Date of Expiry")
//
//        CNWCAlrt26_LS = NSLocalizedString("LS_49", comment: "Please Enter Alert 1 Future Date")
//
//        CNWCAlrt27_LS = NSLocalizedString("LS_50", comment: "Please Enter Alert 2 Future Date")
//
//        CNWCAlrt28_LS = NSLocalizedString("LS_51", comment: "Please Enter Alert 3 Future Date")
//
//        CNWCAlrt29_LS = NSLocalizedString("LS_52", comment: "Please Enter Future Date of Warning")
//
//        MPVAlrt05_LS = NSLocalizedString("LS_53", comment: "Please Enter Expiration Future Date")
//
//        CNWCAlrt30_LS = NSLocalizedString("LS_54", comment: "Cancel")
//        
//        LVCAlrt04_LS = NSLocalizedString("LS_55", comment: "Please Enter Your Email")
//
//        LVCAlrt05_LS = NSLocalizedString("LS_56", comment: "Password sent to your mail")
//    }
    
}
