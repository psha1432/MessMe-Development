//
//  LogInViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

var PhoneNu = String()
var countrycode = String()
var dob = String()
var gender = String()

import UIKit
import ADCountryPicker

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var forgetEmailTf: UITextField!
    @IBOutlet weak var forgetPassView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryCodeTF: UILabel!
    @IBOutlet weak var PhoneNumberTF: UITextField!
    @IBOutlet weak var passCodeTF: UITextField!
    @IBOutlet weak var passImgVw: UIImageView!
    @IBOutlet weak var eyeBtn: UIButton!
    
    
    var eyeAction: Bool = true
    
    var a = String()
    var a1 = String()
    var a2 = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgetPassView.isHidden = true
        
        countryImg.image = UIImage(named:"Tg.png")
        flagImg = UIImage(named:"Tg.png")!
        countryCodeTF.text = "+228"
        
        DataManager.countryImg = flagImg.pngData()
        
        PhoneNumberTF.text = "12312312"
        passCodeTF.text = "12345678"
        
        let checkuserEmail = DataManager.Email
        print("checkuserEmail",checkuserEmail)
        
        passCodeTF.clearsOnBeginEditing = false
//        countryCodeTF.delegate = self
        
//        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        else {
//            return
//        }
//        DataManager.deviceId = deviceID
//        print("deviceID",deviceID) // 7ABAB8B5-E805-437F-9D6C-5448BB19AEA5
    }
    
    
    @IBAction func eyeBtnPressed(_ sender: UIButton) {
        
        if eyeAction {
            eyeBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            eyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        if(eyeAction == true) {
            passCodeTF.isSecureTextEntry = false
        } else {
            passCodeTF.isSecureTextEntry = true
        }
        eyeAction = !eyeAction
        
//        if isPasswordHide == true {
//            passCodeTF.isSecureTextEntry = false
//            isPasswordHide = false
//            if #available(iOS 13.0, *) {
//                passImgVw.image =  UIImage.init(systemName: "eye")
//            } else {
//                passImgVw.image =  UIImage(named: "eye")
//            }
//        }
//        else {
//            passCodeTF.isSecureTextEntry = true
//            isPasswordHide = true
//            if #available(iOS 13.0, *) {
//                passImgVw.image =  UIImage.init(systemName: "eye.slash")
//            } else {
//                // Fallback on earlier versions  eyesalsh
//                passImgVw.image =  UIImage(named: "eyesalsh")
//            }
//        }

    }
    
    
    @IBAction func openPicker(_ sender: Any) {
        let picker = ADCountryPicker(style: .grouped)
               // delegate
            picker.delegate = self
       
               // Display calling codes
            picker.showCallingCodes = true
            picker.showFlags = true
            picker.flagHeight = 40

               // or closure
            picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
//            print(code)
        }
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func forgotPasswordBtn(_ sender: UIButton) {
        
        forgetPassView.isHidden = false
               
    }
    
    @IBAction func cancelForgetBtn(_ sender: UIButton) {
        forgetPassView.isHidden = true
    }
    
    @IBAction func forgetSubmitBtn(_ sender: UIButton) {
        
        if forgetEmailTf.text!.count == 0 {
            CommonFunctions.showAlert(self, message: "Please Enter Your Email".localiz(), title: appName)
        } else {
            forgotPassword()
        }

    }
    
    func forgotPassword() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().ForgotPassword(Email: forgetEmailTf.text!, currentVC: self) { (response) in
         
            print("forgotPassword",response)
            self.showToast(message: "Password sent to your mail".localiz(), font: .systemFont(ofSize: 17.0),yAxis:560.0)
            self.forgetPassView.isHidden = true
            
            CommonFunctions.dismissProgressView(view: self.view)
        
        }
        
    }
    

    @IBAction func loginBackBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        a = countryCodeTF.text!
        a1 = PhoneNumberTF.text!
        a2 = a + " " + a1
        print("logina2",a2)
        
        PhoneNu = PhoneNumberTF.text!
        let intNumber = Int(PhoneNu)
        DataManager.Phonenumber = intNumber
//        print(intNumber,"intNumber")
        countrycode = countryCodeTF.text!
        DataManager.countryCode = countrycode
        
        if(((PhoneNumberTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Phone Number".localiz(), title: appName)
        } else if(((countryCodeTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Country Code".localiz(), title: appName)
        } else if(((passCodeTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter your Password".localiz(), title: appName)
        } else {
            
            Login()
        }
    }
    
    
    //Mark:- Login Api
    func Login() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().Login(PhoneNumber:a2,Password:passCodeTF.text!,DeviceId:DataManager.tokenId!,DeviceType:"IPhone", currentVC: self) { (response) in
            
               print("Loginresponse",response)
            
            dob = response["data"]["Dob"].stringValue
            gender = response["data"]["Gender"].stringValue
            
            DataManager.Email = response["data"]["Email"].stringValue
            DataManager.Name = response["data"]["UserName"].stringValue
            DataManager.Password = response["data"]["Password"].stringValue
            DataManager.UserId = response["data"]["Id"].intValue
            DataManager.isLogin = true
     
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            CommonFunctions.dismissProgressView(view: self.view)
           }
     }
}

extension LogInViewController: ADCountryPickerDelegate {
        
        func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
            _ = picker.navigationController?.popToRootViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            let flagImage =  picker.getFlag(countryCode: code)
            
//            codeContryTF.text = name
//            codeContryTF.text = code
            countryCodeTF.text = dialCode
            countryImg.image = flagImage
            flagImg = flagImage!
            DataManager.countryImg = flagImg.pngData()
            print("flagImagepicker",flagImage)
            
        }
   
    }
