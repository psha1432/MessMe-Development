//
//  CreateAccountViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit
import ADCountryPicker


class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var addViewCA: UIView!
    
    @IBOutlet weak var dobTfDatePicker: UITextField!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var codeContryTF: UILabel!
    @IBOutlet weak var numberPhoneTF: UITextField!
    @IBOutlet weak var passWordTF: UITextField!
    @IBOutlet weak var confirmPassWordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var confirmPassEyeBtn: UIButton!
    
    let gender = ["Male", "Female"]
    var pickerVw1 = UIPickerView()
    var dobinMilli = Int()
    
    var passEyeAction: Bool = true
    var ConfirmEyeAction: Bool = true
    
    var cuntrylbael = String()
    var cuntrylbael1 = String()
    var cuntrylbael2 = String()
    
    private var dd = 0      // The day for testing
    private var mm = 0      // The month for testing
    private var yyyy = 0    // The year for testing
    private var hh = 0      // The hour for testing
    private var mn = 0      // The minutes for testing
    
    let yearMini = 1920        // Allow range from 1 to 2099
    var yearMaxi = 2099     // Never more than 9999 (4 digits)
    
    var cuurentDay = Int()
    var currentmonth = Int()
    var currentYear = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dobTF.text = nil
        dobTF.placeholder = " DOB DD/MM/YYYY"
        
        countryFlag.image = UIImage(named:"Tg.png")
        codeContryTF.text = "+228"
        
        dobTF.delegate = self
        dobTfDatePicker.delegate = self
        dobTfDatePicker.tintColor = UIColor.clear
        dobTfDatePicker.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        
        pickerVw1.delegate = self
        pickerVw1.dataSource = self
        genderTF.inputView = pickerVw1
        
        
        // *** Create date ***
        let date = Date()

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        print("dateComponents day ",dateComponents.day)
        print("dateComponents Month ",dateComponents.month)
        print("dateComponents year ",dateComponents.year)
        cuurentDay = dateComponents.day ?? 0
        currentmonth = dateComponents.month ?? 0
        currentYear = dateComponents.year ?? 0
        yearMaxi = currentYear-1
        print("cuurentDay day ", cuurentDay)
        print("currentmonth Month ", currentmonth)
        print("currentYear year ", currentYear)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    @IBAction func passEyeBtnAct(_ sender: UIButton) {
        if passEyeAction {
            passEyeBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passEyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        if(passEyeAction == true) {
            passWordTF.isSecureTextEntry = false
        } else {
            passWordTF.isSecureTextEntry = true
        }
        passEyeAction = !passEyeAction
        
    }
    
    @IBAction func confirmPassEyeBtn(_ sender: UIButton) {
        if ConfirmEyeAction {
            confirmPassEyeBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            confirmPassEyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        if(ConfirmEyeAction == true) {
            confirmPassWordTF.isSecureTextEntry = false
        } else {
            confirmPassWordTF.isSecureTextEntry = true
        }
        ConfirmEyeAction = !ConfirmEyeAction
        
    }
    
    
   
    @IBAction func openPickerAction(_ sender: Any) {

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
        
    @IBAction func dobTfAction(_ sender: UITextField) {
            
            if sender.text == nil || sender.text == "" {
                dobLbl.textColor = .black
            }
            
            let calendar = Calendar.current
            let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
        
            
            let date = calendar.date(from: dateComponents)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
            let realMonth = Int(dateFormatter.string(from: date))
            if realMonth == nil || realMonth! != self.mm {
                dobLbl.textColor = .red  // For 29/2 on a non-leap year
            } else {
                dobLbl.textColor = .black
            }
            
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dobLbl.text = dateFormatter.string(from: date)
            print("dobLbl",dobLbl!)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == dobTF {
        
            var isValid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = dobTF.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    isValid = ((dobTF.text!.count <= 1 && newValue >= 1) || (dobTF.text!.count == 0 && newValue <= 3)) && newValue <= 31
                    self.dd = newValue   // For further use
                } else {        // Did not type a Int
                    isValid = false // Not a number
                }
                if !isValid {   // Not valid, let's beep and return false: we ignore the typing
                    return false
                }
            } else if textField.text!.count >= 3  && textField.text!.count <= 4 {  // Between 3 and 4 char max have been typed or inserted (dd/ to dd/m), we analyse the next one typed (string)
                // backspace inserts nothing: string is ""
                // Is MM Valid ?
                let newString = String((dobTF.text! + string).dropFirst(3))  // removes 'DD/'
                if string == "" { // case of backspace
                    // skip if we typed backspace after a /
                    // isValid remains true, we do nothing
                } else {  // we had txtValue.text! + string = dd/ and something
                    if let newValue = Int(newString) {
                        // So we typed something in MM (newString) and it is a valid number
                        // a valid mm must be between 1 and 12
                        // But if textField.text!.count == 3, first char of newString may be 0, waiting for the second
                        // isValid = newValue >= 0 && newValue <= 12  Not precise enough
                        // If we backspace at dd/m, we have 4 chars, string is "", but m may be 0: do not require newvalue >= 1
                        isValid = textField.text!.count == 3 || (textField.text!.count == 4 && (newValue >= 1 || string == "") && newValue <= 12)
                        self.mm = newValue
                        
                        // If we have typed a non zero value, is it a valid month ?
                        if isValid {    // Some months have 30 days max
                            if [4, 6, 9, 11].contains(mm) {
                                isValid = dd <= 30
                            }
                            if mm == 2 {
                                isValid = dd <= 29  // May be a leap year: will be handled when displaying label
                            }
                        }
                    } else {
                        isValid = false // mm Not a number
                    }
                    if !isValid {
                        return false
                    }
                }
            } else if textField.text!.count >= 6  && textField.text!.count <= 9 {  // Between 6 and 9 char max have been typed or inserted (dd/mm/ to dd/mm/yyy), we analyse the next one typed (string)
                // backspace inserts nothing: string is ""
                // Is YYYY Valid ?
                let newString = String((dobTF.text! + string).dropFirst(6))  // removes 'DD/mm/'
                if string == "" { // case of backspace
                    // skip if we typed backspace after a /
                    // isValid remains true, we do nothing
                } else {  // we had txtValue.text! + string = dd/mm/ and something
                    if let newValue = Int(newString) {
                        // So we typed something in YYYY (newString) and it is a valid number
                        // a valid yyyy must be between yearMini and yearMaxi ?
                        // if textField.text!.count == 6, first char of newString can be 0, waiting for the second
                        isValid = newValue >= 1 && newValue <= yearMaxi //  Not precise enough
                        isValid = isValid || (newValue == 0 && string == "")     // Typed backspace when year isonly leading 0
                        // if textField.text!.count == 6, first char of newString can also be 0, waiting for the second or third or fourth
                        isValid = isValid || (textField.text!.count >= 6 && textField.text!.count <= 8 && string == "0")
                        // If we backspace at dd/m, we have 4 chars, string is "", but m may be 0: do not require newvalue >= 1
                        self.yyyy = newValue
                        
                        // If we have typed a complete yyyy, is it a valid year ?  backspace remains possible
                        if isValid && textField.text!.count == 9 && string != "" {    // Must be between yearMini and yearMaxi
                            isValid = yyyy >= yearMini && yyyy <= yearMaxi
                        }
                    } else {
                        isValid = false // yyyy Not a number
                    }
                    if !isValid {
                        return false
                    }
                }
                // Now test time
            }
            //Handle backspace being pressed : string.count == 0
            // We remove the special character that was added plus the new that was typed
            if string.count == 0 && (textField.text?.last == "/" || textField.text?.last == " " || textField.text?.last == ":") {
                dobTF.text = String((dobTF.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    dobTF.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    dobTF.text = textField.text! + string + ""
                    return false
                }
            }
            //        else if (textField.text?.count == 12) {
            //            // We have dd/mm/yyyy h and typed a new char
            //            if string != "" {  // Not a backspace: let's add ":" after hh
            //                dateTF.text = textField.text! + string + ":"
            //                return false
            //            }
            //        }
            if string == "\t" && textField.text!.count >= 9 {  // "Tab": we force exit
                dobTfAction(textField)
                textField.resignFirstResponder()
                return false
            }
        }
        
        if string == "\n" && textField.text!.count >= 9 { return true } // We hit 'Return' at the end, with a valid date
        
        return !(textField.text!.count > 9 && (string.count) > range.length)
        
        }
    

    @IBAction func backBTnAct(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    

    @IBAction func btnCreateAcc(_ sender: UIButton) {
        print("doblabel;",dobLbl.text)
        
        cuntrylbael = codeContryTF.text!
        cuntrylbael1 = numberPhoneTF.text!
        cuntrylbael2 = cuntrylbael + " " + cuntrylbael1
        print("cuntrylbael2",cuntrylbael2)
        
        if (((numberPhoneTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))) {
            CommonFunctions.showAlert(self, message: "Please Enter Phone Number".localiz(), title: appName)
        } else if isValidphoneNumber(phone: numberPhoneTF.text!) == false {
            CommonFunctions.showAlert(self, message: "Number Should Not Be Less Then 8 Digit".localiz(), title: appName)
        } else if(((codeContryTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Fill Country Code".localiz(), title: appName)
        } else if(((passWordTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Password".localiz(), title: appName)
        } else if isPasswordValid(passWordTF.text!) == false {
            CommonFunctions.showAlert(self, message: "Enter 8 Digit Password".localiz(), title: appName)
        } else if(((confirmPassWordTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Confirm Password".localiz(), title: appName)
        } else if passWordTF.text != confirmPassWordTF.text {
            CommonFunctions.showAlert(self, message: "Password and Confirm Password is not matched.".localiz(), title: appName)
        } else if(((emailTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Email".localiz(), title: appName)
        } else if isValidEmail(emailTF.text!) == false {
            CommonFunctions.showAlert(self, message: "Enter Proper Email".localiz(), title: appName)
        } else if (dobTF.text?.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter DOB".localiz(), title: appName)
        } else if isDateValid(dobTF.text!) == false {
            CommonFunctions.showAlert(self, message: "Please Enter Valid DOB Date".localiz(), title: appName)
        } else if(((genderTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Select Your Gender".localiz(), title: appName)
        } else if(((firstNameTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter First Name".localiz(), title: appName)
        }
        else {
            
            Register()
        }
    }
    
    func isDateValid(_ date : String) -> Bool{
        let dateTest = NSPredicate(format: "SELF MATCHES %@", "[0-9]{2}[-|/]{1}[0-9]{2}[-|/]{1}[0-9]{4}")
        return dateTest.evaluate(with: date)
    }
    
    //Mark:- Register Api
    func Register() {
        CommonFunctions.startProgressView(view: self.view)
      
        
        APIController().Registration(Id:0,Name:firstNameTF.text!,Email:emailTF.text!,PhoneNumber:cuntrylbael2,Password:passWordTF.text!,Dob:dobLbl.text!,Gender:genderTF.text!, currentVC: self ) { (response) in
         
            print("Createresponse",response)
            
            DataManager.Email = response["data"]["Email"].stringValue
//            DataManager.Phonenumber = response["data"]["PhoneNumber"].intValue
            DataManager.UserId = response["data"]["Id"].intValue
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            self.navigationController?.pushViewController(vc, animated: false)
            
            CommonFunctions.dismissProgressView(view: self.view)
        }
    }
    
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.dobTfDatePicker.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.dateStyle = .medium
            self.dobTF.text = dateFormatter.string(from: datePicker.date)
            self.dobLbl.text = dateFormatter.string(from: datePicker.date)
            // date to milliseconds
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dobTF.text = dateFormatter.string(from: datePicker.date)
            dobLbl.text = dateFormatter.string(from: datePicker.date)
            let nowDouble = datePicker.date.timeIntervalSince1970
            dobinMilli = Int(nowDouble*1000)
            print("dobinMilli",dobinMilli)

        }
        self.dobTfDatePicker.resignFirstResponder()
    }
    
}
    
extension CreateAccountViewController: ADCountryPickerDelegate {
        
        func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
            _ = picker.navigationController?.popToRootViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            let flagImage =  picker.getFlag(countryCode: code)
            

//            codeContryTF.text = name
//            codeContryTF.text = code
            codeContryTF.text = dialCode
            countryFlag.image = flagImage
            
        }
    }

extension CreateAccountViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //https://cocoapods.org/pods/ADCountryPicker
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return gender.count
        }
        
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTF.text = "\(gender[row])"
        //        genderTF.text = gender[row]
        genderTF.resignFirstResponder()
    }
}


extension UIViewController {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
           let passwordTest = NSPredicate(format: "SELF MATCHES %@", "([(0-9)(A-Z)(a-z)(!@#$%ˆ&*+-=<>)]+){8,}")
           return passwordTest.evaluate(with: password)
       }
    
    func isValidUsername(_ Username:String) -> Bool {
        let Test = NSPredicate(format:"SELF MATCHES %@","\\A\\w{4,12}\\z" )
        return Test.evaluate(with: Username)
    }
    
    func isValidphoneNumber(phone: String) -> Bool {
        let phoneRegex = "\\w{8,14}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
}

extension UITextField {

    func addInputViewDatePicker(target: Any, selector: Selector) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date

        let todaysDate = Date()
        datePicker.maximumDate = todaysDate

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePicker

        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }

    @objc func cancelPressed() {
        self.resignFirstResponder()
    }

}
