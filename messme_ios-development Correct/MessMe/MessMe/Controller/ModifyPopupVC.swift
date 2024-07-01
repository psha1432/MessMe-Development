//
//  ModifyPopupVC.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit

class ModifyPopupVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var modifyBackVw: UIView!
    @IBOutlet weak var closeBtnPopVw: UIViewCustomClass!
    @IBOutlet weak var modifyPopupVw: UIViewCustomClass!
    
    @IBOutlet weak var expiryDate: UILabel!
    @IBOutlet weak var newDateExpiryTf: UITextField!
    @IBOutlet weak var newDateExpiryLbl: UILabel!
    
    @IBOutlet weak var warningTextVw: UITextView!
    @IBOutlet weak var instanceTextVw: UITextView!
    
    var cuurentDay = Int()
    var currentmonth = Int()
    var currentYear = Int()
    
    private var dd = 0      // The day for testing
    private var mm = 0      // The month for testing
    private var yyyy = 0    // The year for testing
    private var hh = 0      // The hour for testing
    private var mn = 0      // The minutes for testing
    
    var yearMini = 1        // Allow range from 1 to 2099
    let yearMaxi = 2099     // Never more than 9999 (4 digits)
    
    var expiryMatchCurrentDate = Int()
    var expirymilli = Int()
    var expirymillistring = String()
    var newDateExpiryString = String()
    
    var WarningDetailsById = [JSON]()
    var warName = String()
    var dateCreation = String()
    var dateCreationInt = Int()
    var iWarningType = String()
    
    var expiryDateShow = String()
    var expiryDateShowInt = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newDateExpiryTf.text = nil
        newDateExpiryTf.placeholder = "DD/MM/YYYY"
        newDateExpiryTf.delegate = self
        
        self.iWarningType = self.WarningDetailsById[0]["IsWarningType"].stringValue
        self.dateCreation = self.WarningDetailsById[0]["CreatedDate"].stringValue
        self.warName = self.WarningDetailsById[0]["WarningName"].stringValue
        
        self.expiryDateShow = self.WarningDetailsById[0]["ExpirationDate"].stringValue
        self.instanceTextVw.text = self.WarningDetailsById[0]["Instance"].stringValue
        self.warningTextVw.text = self.WarningDetailsById[0]["WarningDetails"].stringValue
        
        print(dateCreation,"dateCreation")
        //string to int
        dateCreationInt = Int(dateCreation)!
        print("dateCreationInt",dateCreationInt)
        
        
        // miliseconds to date convert
        let milliseconds=expiryDateShow
        print(milliseconds,"milliseconds")
        let Doublemilliseconds = Double(expiryDateShow)
        
        let Expirydate = Date(timeIntervalSince1970: (Doublemilliseconds! / 1000.0))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        print("ModifyExpirydate",formatter.string(from: Expirydate as Date))
        
        expiryDate.text = "\(formatter.string(from: Expirydate as Date ))"
        newDateExpiryTf.text = "\(formatter.string(from: Expirydate as Date ))"
        
        //string to int
        expiryDateShowInt = Int(expiryDateShow)!
        print("expiryDateShowInt",expiryDateShowInt)
        
        modifyBackVw.alpha = 0.5
        modifyPopupVw.isHidden = false
        closeBtnPopVw.isHidden = false
        modifyBackVw.isHidden = false
        
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
        yearMini = currentYear
        print("cuurentDay day ", cuurentDay)
        print("currentmonth Month ", currentmonth)
        print("currentYear year ", currentYear)
        
        //Datepicker
        newDateExpiryTf.datePicker(target: self, selector: #selector(doneButtonPressed))
        
    }
    
    @IBAction func closeBtnPress(_ sender: UIButton) {
        modifyBackVw.isHidden = true
        modifyPopupVw.isHidden = true
        closeBtnPopVw.isHidden = true
        self.dismiss(animated: true, completion: nil)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentWarningVC") as! MyCurrentWarningVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        modifyBackVw.isHidden = true
        modifyPopupVw.isHidden = true
        closeBtnPopVw.isHidden = true
        self.dismiss(animated: true, completion: nil)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentWarningVC") as! MyCurrentWarningVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func newExpiryDate(_ sender: UITextField) {
//        if sender.text == nil || sender.text == "" {
//            newDateExpiryLbl.textColor = .black
//        }
        
//        let calendar = Calendar.current
//        let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
//
//        let date = calendar.date(from: dateComponents)!
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
//        let realMonth = Int(dateFormatter.string(from: date))
//        if realMonth == nil || realMonth! != self.mm {
//            newDateExpiryLbl.textColor = .red  // For 29/2 on a non-leap year
//        } else {
//            newDateExpiryLbl.textColor = .black
//        }
        
//        newDateExpiryString = newDateExpiryTf.text!
//        print(newDateExpiryString,"newDateExpiryString")
//        if newDateExpiryTf.text!.count > 5 {
//        let alert3 = DateFormatter()
//        let dtStr3 = newDateExpiryString
//        alert3.dateFormat = "dd/MM/yyyy"
//        let combineDate3 = alert3.date(from: dtStr3)
//        let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
//
//        // date to milliseconds
//        let nowDouble3 = combineDate3!.timeIntervalSince1970
//        expirymilli = Int(nowDouble3*1000)
//        print("expirymilli",expirymilli)
//            // int to string
//        newDateExpiryString = String(expirymilli)
//            print("newDateExpiryString",newDateExpiryString)
//        }
        
//        // date to milliseconds
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        newDateExpiryTf.text = dateFormatter.string(from: date)
//        let nowDouble = date.timeIntervalSince1970
//        expirymilli = Int(nowDouble*1000)
//        // int to string
//        expirymillistring = String(expirymilli)
//        print("expirymillistring",expirymillistring)
//        print("expirymilli",expirymilli)
////        print("NewDateExpiryLabel",newDateExpiryLbl!)
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            var Valid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = newDateExpiryTf.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    Valid = ((newDateExpiryTf.text!.count <= 1 && newValue >= 1) || (newDateExpiryTf.text!.count == 0 && newValue <= 3)) && newValue <= 31
                    self.dd = newValue   // For further use
                } else {        // Did not type a Int
                    Valid = false // Not a number
                }
                if !Valid {   // Not valid, let's beep and return false: we ignore the typing
                    return false
                }
            } else if textField.text!.count >= 3  && textField.text!.count <= 4 {  // Between 3 and 4 char max have been typed or inserted (dd/ to dd/m), we analyse the next one typed (string)
                // backspace inserts nothing: string is ""
                // Is MM Valid ?
                let newString = String((newDateExpiryTf.text! + string).dropFirst(3))  // removes 'DD/'
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
                        Valid = textField.text!.count == 3 || (textField.text!.count == 4 && (newValue >= 1 || string == "") && newValue <= 12)
                        self.mm = newValue
                        
                        // If we have typed a non zero value, is it a valid month ?
                        if Valid {    // Some months have 30 days max
                            if [4, 6, 9, 11].contains(mm) {
                                Valid = dd <= 30
                            }
                            if mm == 2 {
                                Valid = dd <= 29  // May be a leap year: will be handled when displaying label
                            }
                        }
                    } else {
                        Valid = false // mm Not a number
                    }
                    if !Valid {
                        return false
                    }
                }
            } else if textField.text!.count >= 6  && textField.text!.count <= 9 {  // Between 6 and 9 char max have been typed or inserted (dd/mm/ to dd/mm/yyy), we analyse the next one typed (string)
                // backspace inserts nothing: string is ""
                // Is YYYY Valid ?
                let newString = String((newDateExpiryTf.text! + string).dropFirst(6))  // removes 'DD/mm/'
                if string == "" { // case of backspace
                    // skip if we typed backspace after a /
                    // isValid remains true, we do nothing
                } else {  // we had txtValue.text! + string = dd/mm/ and something
                    if let newValue = Int(newString) {
                        // So we typed something in YYYY (newString) and it is a valid number
                        // a valid yyyy must be between yearMini and yearMaxi ?
                        // if textField.text!.count == 6, first char of newString can be 0, waiting for the second
                        Valid = newValue >= 1 && newValue <= yearMaxi //  Not precise enough
                        Valid = Valid || (newValue == 0 && string == "")     // Typed backspace when year isonly leading 0
                        // if textField.text!.count == 6, first char of newString can also be 0, waiting for the second or third or fourth
                        Valid = Valid || (textField.text!.count >= 6 && textField.text!.count <= 8 && string == "0")
                        // If we backspace at dd/m, we have 4 chars, string is "", but m may be 0: do not require newvalue >= 1
                        self.yyyy = newValue
                        
                        // If we have typed a complete yyyy, is it a valid year ?  backspace remains possible
                        if Valid && textField.text!.count == 9 && string != "" {    // Must be between yearMini and yearMaxi
                            Valid = yyyy >= yearMini && yyyy <= yearMaxi
                        }
                    } else {
                        Valid = false // yyyy Not a number
                    }
                    if !Valid {
                        return false
                    }
                }
                // Now test time
            }
            //Handle backspace being pressed : string.count == 0
            // We remove the special character that was added plus the new that was typed
            if string.count == 0 && (textField.text?.last == "/" || textField.text?.last == " " || textField.text?.last == ":") {
                newDateExpiryTf.text = String((newDateExpiryTf.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    newDateExpiryTf.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    newDateExpiryTf.text = textField.text! + string + ""
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
                newExpiryDate(textField)
                textField.resignFirstResponder()
                return false
            }
            if string == "\n" && textField.text!.count >= 9 { return true } // We hit 'Return' at the end, with a valid date

            return !(textField.text!.count > 9 && (string.count) > range.length)
        }
    
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
        newDateExpiryString = newDateExpiryTf.text!
        print(newDateExpiryString,"newDateExpiryString")
        if newDateExpiryTf.text!.count > 9 {
        let alert3 = DateFormatter()
        let dtStr3 = newDateExpiryString
        alert3.dateFormat = "dd/MM/yyyy"
        let combineDate3 = alert3.date(from: dtStr3)
        let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
        
        // date to milliseconds
        let nowDouble3 = combineDate3!.timeIntervalSince1970
        expirymilli = Int(nowDouble3*1000)
        print("expirymilli",expirymilli)
            // int to string
        newDateExpiryString = String(expirymilli)
            print("newDateExpiryString",newDateExpiryString)
        }
        if (newDateExpiryTf.text!.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Date of Expiration".localiz(), title: appName)
        } else if isDateValid(newDateExpiryTf.text!) == false {
            CommonFunctions.showAlert(self, message: "Enter Valid Date".localiz(), title: appName)
        }
        else if expirymilli <= dateCreationInt {
            CommonFunctions.showAlert(self, message: "Please Enter Expiration Future Date".localiz(), title: appName)
        }
        else if(((instanceTextVw.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
        } else if(((warningTextVw.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
        }
        else {
            
                AddWarning()
        }
    }
    
    func isDateValid(_ date : String) -> Bool{
        let dateTest = NSPredicate(format: "SELF MATCHES %@", "[0-9]{2}[-|/]{1}[0-9]{2}[-|/]{1}[0-9]{4}")
        return dateTest.evaluate(with: date)
    }
    
    //Mark:- AddWarning Api
    func AddWarning() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().AddWarning(Id: DataManager.Id!, UserId: "\(DataManager.UserId!)", WarningName: warName, ExpirationDate: newDateExpiryString, Instance: instanceTextVw.text!, AlertChannel: "", PaymentChannel: "", WarningDetails: warningTextVw.text!, BillingMethod: "", IsWarningType: iWarningType, IsDropWarning: false, CreatedDate: dateCreation, WarningTypeDateTime: "", currentVC: self ) {
            
            (response) in
            
            print("AddWarningResponse",response)
            
            self.modifyBackVw.isHidden = true
            self.modifyPopupVw.isHidden = true
            self.closeBtnPopVw.isHidden = true
            self.dismiss(animated: true, completion: nil)
            
            Foundation.NotificationCenter.default.post(name: NSNotification.Name("ApiReload"),object: nil)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentWarningVC") as! MyCurrentWarningVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            CommonFunctions.dismissProgressView(view: self.view)
        }
        
    }


    @objc func doneButtonPressed() {
        if let  datePicker = self.newDateExpiryTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.dateStyle = .medium
            self.newDateExpiryTf.text = dateFormatter.string(from: datePicker.date)
        }
        self.newDateExpiryTf.resignFirstResponder()
    }
    
}

extension UITextField {

    func datePicker(target: Any, selector: Selector) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
//        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.datePickerMode = .date
        let todaysDate = Date()
        datePicker.minimumDate = todaysDate
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePicker

        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPres))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }

    @objc func cancelPres() {
        self.resignFirstResponder()
    }

}
