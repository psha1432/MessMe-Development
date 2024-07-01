//
//  EditProfileDetailVC.swift
//  
//
//  Created by Prashant Sharma on 16/06/22.
//
var flagImg = UIImage()
import UIKit
import ADCountryPicker

class EditProfileDetailVC: UIViewController {
    
    @IBOutlet weak var coutryCode: UILabel!
    @IBOutlet weak var coutryImg: UIImageView!
    @IBOutlet weak var passImgVw: UIImageView!
    @IBOutlet weak var editnameTf: UITextField!
    @IBOutlet weak var editPhoneTf: UITextField!
    @IBOutlet weak var editPasswordTf: UITextField!
    @IBOutlet weak var editEmailAdd: UITextField!
    @IBOutlet weak var passwordEyeBtnAct: UIButton!
    
    var countryCodePhoneNumber = String()
    var eyeAction: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let flag = DataManager.countryImg!
        print("flag",flag)
        let pngImage = UIImage(data: flag)
        coutryImg.image = pngImage

        
        editnameTf.text = DataManager.Name
        editPasswordTf.text = DataManager.Password
        editEmailAdd.text = DataManager.Email
        editPhoneTf.text = "\(String(describing: DataManager.Phonenumber!))"
        coutryCode.text = DataManager.countryCode
        
//        editEmailAdd.isUserInteractionEnabled = false
    }
    
    
    @IBAction func eyeBtnPressed(_ sender: UIButton) {
        
        if eyeAction {
            passwordEyeBtnAct.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordEyeBtnAct.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        if(eyeAction == true) {
            editPasswordTf.isSecureTextEntry = false
        } else {
            editPasswordTf.isSecureTextEntry = true
        }
        eyeAction = !eyeAction
        
//        if isPasswordHide == true {
//            editPasswordTf.isSecureTextEntry = false
//            isPasswordHide = false
//            if #available(iOS 13.0, *) {
//                passImgVw.image =  UIImage.init(systemName: "eye")
//            } else {
//                passImgVw.image =  UIImage(named: "eye")
//            }
//        }
//        else {
//            editPasswordTf.isSecureTextEntry = true
//            isPasswordHide = true
//            if #available(iOS 13.0, *) {
//                passImgVw.image =  UIImage.init(systemName: "eye.slash")
//            } else {
//                // Fallback on earlier versions  eyesalsh
//                passImgVw.image =  UIImage(named: "eyesalsh")
//            }
//        }
    }
    
    
    @IBAction func openPickerBtnAction(_ sender: UIButton) {
        
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
            print(code)
        }
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
        
    
    

    @IBAction func editSaveBtn(_ sender: UIButton) {
        
        countrycode = coutryCode.text!
        PhoneNu = editPhoneTf.text!
        countryCodePhoneNumber = countrycode + " " + PhoneNu
        print(countryCodePhoneNumber,"countryCodePhoneNumber")
        
        if (editnameTf.text?.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Name".localiz(), title: appName)
        }
        else if (((editPhoneTf.text!.trimmingCharacters(in: .whitespaces).isEmpty))) {
            CommonFunctions.showAlert(self, message: "Please Enter Phone Number".localiz(), title: appName)
        } else if isValidphoneNumber(phone: editPhoneTf.text!) == false {
            CommonFunctions.showAlert(self, message: "Number Should Not Be Less Then 8 Digit".localiz(), title: appName)
        } else if(((coutryCode.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Country Code".localiz(), title: appName)
        }
         else if(((editPasswordTf.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
             CommonFunctions.showAlert(self, message: "Please Enter Password".localiz(), title: appName)
        } else if isPasswordValid(editPasswordTf.text!) == false {
            CommonFunctions.showAlert(self, message: "Enter 8 Digit Password".localiz(), title: appName)
        }
        else {
            Register()
        }
    }
    
    
    @IBAction func editBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func editCancelBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //Mark:- Register Api
    func Register() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().Registration(Id:DataManager.UserId!,Name:editnameTf.text!,Email:editEmailAdd.text!,PhoneNumber:countryCodePhoneNumber,Password:editPasswordTf.text!,Dob:dob,Gender:gender, currentVC: self ) { (response) in
         
            print("editSaveDetailResponse",response)
            
            DataManager.Name = response["data"]["UserName"].stringValue
            DataManager.Password = response["data"]["Password"].stringValue
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
            self.navigationController?.pushViewController(vc, animated: false)
            
            CommonFunctions.dismissProgressView(view: self.view)
        }
    }
    
}

extension EditProfileDetailVC: ADCountryPickerDelegate {
        
        func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
            _ = picker.navigationController?.popToRootViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            let flagImage =  picker.getFlag(countryCode: code)
//            codeContryTF.text = name
//            codeContryTF.text = code
            coutryCode.text = dialCode
            coutryImg.image = flagImage
            print("coutryImg",coutryImg)
        }
    }

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
