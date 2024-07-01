//
//  CreateNewWarningViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//
import UIKit

class CreateNewWarningViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var alert3DatePickerTf: UITextField!
    @IBOutlet weak var alert2DatePickerTf: UITextField!
    @IBOutlet weak var alert1DatePickerTf: UITextField!
    @IBOutlet weak var oneDatePickerTf: UITextField!
    @IBOutlet weak var expiryDatePickerTf: UITextField!
    @IBOutlet weak var statusBarName: UILabel!
    @IBOutlet weak var alert1DateLbl: UILabel!
    @IBOutlet weak var alert2DateLbl: UILabel!
    @IBOutlet weak var alert3DateLbl: UILabel!
    @IBOutlet weak var alert3DateTf: UITextField!
    @IBOutlet weak var alert2DateTf: UITextField!
    @IBOutlet weak var alert1DateTf: UITextField!
    @IBOutlet weak var alert3Tf: UITextField!
    @IBOutlet weak var alert2Tf: UITextField!
    @IBOutlet weak var alert1Tf: UITextField!
    @IBOutlet weak var oneTimeDateLbl: UILabel!
    @IBOutlet weak var oneTimeTf: UITextField!
    @IBOutlet weak var oneTimeDateTf: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var billingVw: UIViewCustomClass!
    @IBOutlet weak var chooseBillingLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var instanceTF: UITextView!
    @IBOutlet weak var detailTF: UITextView!
    @IBOutlet weak var alertTF: UITextField!
    @IBOutlet weak var paymentTF: UITextField!
    @IBOutlet weak var billTF: UITextField!
    @IBOutlet weak var warningTypeTf: UITextField!
    @IBOutlet weak var selectWarning: NSLayoutConstraint!
    @IBOutlet weak var oneTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var recurringHeight: NSLayoutConstraint!
    @IBOutlet weak var alert1Height: NSLayoutConstraint!
    @IBOutlet weak var alert2Height: NSLayoutConstraint!
    @IBOutlet weak var alert3Height: NSLayoutConstraint!
    @IBOutlet weak var oneTimeVw: UIViewCustomClass!
    @IBOutlet weak var recurringVw: UIView!
    
    
    private var dd = 0      // The day for testing
    private var mm = 0      // The month for testing
    private var yyyy = 0    // The year for testing
    private var hh = 0      // The hour for testing
    private var mn = 0      // The minutes for testing
    
    var yearMini = 1        // Allow range from 1 to 2099
    let yearMaxi = 2099     // Never more than 9999 (4 digits)
    
    var cuurentDay = Int()
    var currentmonth = Int()
    var currentYear = Int()
    
    var expiryMatchtoCurrentDate = Int()
    
    var createDate = Int()
    var expirydateinmili = Int()
    var expirydateinmiliString = String()
    
    var oneDateTime = String()
    var oneTimeDateMilliseconds = Int()
    var oneTimeDateString = String()
    
    var alertDateTime1 = String()
    var alertDateTime2 = String()
    var alertDateTime3 = String()
    
    var alertDateTime1Mili1 = Int()
    var alertDateTime1Mili2 = Int()
    var alertDateTime1Mili3 = Int()
    
    var alertDateTime1String = String()
    var alertDateTime2String = String()
    var alertDateTime3String = String()
    
    var timeDateStamp = String()
    
    var otherservicelblName = String()
    var Payment = ["Mobile Money","Paypal"]
    let pickerView2 = UIPickerView()
    
    var warningType = ["Recurring","One time"]
    let pickerView3 = UIPickerView()
    
    //    let Billing = ["PAYG", "Forfeit"]
    //    let pickerView1 = UIPickerView()
    var addWarningData = [JSON]()
    var addWarningId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWarningId = 0
        dateTF.delegate = self
        oneTimeDateTf.delegate = self
        alert1DateTf.delegate = self
        alert2DateTf.delegate = self
        alert3DateTf.delegate = self
        
        expiryDatePickerTf.delegate = self
        oneDatePickerTf.delegate = self
        alert1DatePickerTf.delegate = self
        alert2DatePickerTf.delegate = self
        alert3DatePickerTf.delegate = self
        
        expiryDatePickerTf.tintColor = UIColor.clear
        oneDatePickerTf.tintColor = UIColor.clear
        alert1DatePickerTf.tintColor = UIColor.clear
        alert2DatePickerTf.tintColor = UIColor.clear
        alert3DatePickerTf.tintColor = UIColor.clear
        
        expiryDatePickerTf.datePicker(target: self, selector: #selector(expiryDatePickerTfDone))
        oneDatePickerTf.datePicker(target: self, selector: #selector(oneDatePickerTfDone))
        alert1DatePickerTf.datePicker(target: self, selector: #selector(alert1DatePickerTfDone))
        alert2DatePickerTf.datePicker(target: self, selector: #selector(alert2DatePickerTfDone))
        alert3DatePickerTf.datePicker(target: self, selector: #selector(alert3DatePickerTfDone))
        
        instanceTF.layer.borderColor = UIColor.lightGray.cgColor
        detailTF.layer.borderColor = UIColor.lightGray.cgColor
        
        nameTF.text = otherservicelblName
        
        chooseBillingLbl.isHidden = true
        billingVw.isHidden = true
        
        
        oneTimeTf.addInputDatePicker(target: self, selector: #selector(doneButtonPressed))
        alert1Tf.addInputDatePicker(target: self, selector: #selector(alert1doneButtonPressed))
        alert2Tf.addInputDatePicker(target: self, selector: #selector(alert2doneButtonPressed))
        alert3Tf.addInputDatePicker(target: self, selector: #selector(alert3doneButtonPressed))
        
        //        pickerView1.delegate = self
        //        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        warningTypeTf.inputView = pickerView3
        paymentTF.inputView = pickerView2
        
        //        billTF.inputView = pickerView3
        
        //        self.alertTF.text = alert[0]
        //        self.paymentTF.text = Payment[0]
        
        warningTypeTf.text = warningType[0]
        oneTimeVw.isHidden = true
        oneTimeHeight.constant = 0
        selectWarning.constant = 230
        recurringHeight.constant = 191
        alert1Height.constant = 55
        alert2Height.constant = 55
        alert3Height.constant = 55
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reloadaction),
                                               name: NSNotification.Name("FillData"),
                                               object: nil)
        
        // add warning time pick current date
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var DateInFormat = dateFormatter.string(from: todaysDate as Date)
        print("DateInFormat",DateInFormat)
        
        // date to milliseconds
        dateFormatter.dateFormat = "dd/MM/yyyy"
        DateInFormat = dateFormatter.string(from: todaysDate as Date)
        let nowDouble = todaysDate.timeIntervalSince1970
        createDate = Int(nowDouble*1000)
        print("createDate",createDate)
        
        
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
        
        if isClickModify == true {
            statusBarName.text = "Modify Warning"
            addWarningDetailsData()
        } else {
            statusBarName.text = "Create New Warning"
        }
    }
    
    
    func addWarningDetailsData() {
        
        if addWarningData.count > 0 {
            
            nameTF.text = addWarningData[0]["WarningName"].stringValue
            addWarningId = addWarningData[0]["Id"].intValue
            expirydateinmili = addWarningData[0]["ExpirationDate"].intValue
            
            // miliseconds to date
            let milliseconds = expirydateinmili
            let Doublemilliseconds = Double(milliseconds)
            
            let Expirydate = Date(timeIntervalSince1970: (Doublemilliseconds / 1000.0))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            print("ModifyExpirydate",formatter.string(from: Expirydate as Date))
            dateTF.text = "\(formatter.string(from: Expirydate as Date ))"
            let data = dateTF.text!
            print(data,"expdate")
            expirydateinmiliString = dateTF.text!
            dateLabel.text = expirydateinmiliString
            
            // int to string
            expirydateinmiliString = String(expirydateinmili)
            print("expirydateinmiliString",expirydateinmiliString)
            
            let AddwarningType = addWarningData[0]["WarningTypeDateTime"].arrayValue
            print("WarningTypeCheck",AddwarningType)
            
            if AddwarningType.count == 3 {
                warningTypeTf.text = warningType[0]
                oneTimeHeight.constant = 0
                recurringVw.isHidden = false
                oneTimeVw.isHidden = true
                selectWarning.constant = 230
                recurringHeight.constant = 191
                alert1Height.constant = 55
                alert2Height.constant = 55
                alert3Height.constant = 55
            }
            else if AddwarningType.count == 1 {
                warningTypeTf.text = warningType[1]
                oneTimeVw.isHidden = false
                recurringVw.isHidden = true
                selectWarning.constant = 80
                oneTimeHeight.constant = 61
                recurringHeight.constant = 0
                alert1Height.constant = 0
                alert2Height.constant = 0
                alert3Height.constant = 0
            }
            
            // miliseconds to date convert one date
            for i in 0..<AddwarningType.count {
                let millis=AddwarningType[i].stringValue
                print(millis,"milliseconds")
                let Doublmilliseconds = Double(millis)
                
                let onedate = Date(timeIntervalSince1970: (Doublmilliseconds! / 1000.0))
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "dd/MM/yyyy"
                print("onedate",dateformatter.string(from: onedate as Date))
                
                if AddwarningType.count == 1 {
                    oneTimeDateTf.text = "\(formatter.string(from: onedate as Date ))"
                    oneTimeDateLbl.text = "\(formatter.string(from: onedate as Date ))"
                }
                else {
                    if i == 0 {
                        alert1DateTf.text = "\(formatter.string(from: onedate as Date ))"
                        alert1DateLbl.text = "\(formatter.string(from: onedate as Date ))"
                    }
                    else if i == 1 {
                        alert2DateTf.text = "\(formatter.string(from: onedate as Date ))"
                        alert2DateLbl.text = "\(formatter.string(from: onedate as Date ))"
                    }
                    else if i == 2 {
                        alert3DateTf.text = "\(formatter.string(from: onedate as Date ))"
                        alert3DateLbl.text = "\(formatter.string(from: onedate as Date ))"
                    }
                }
                
                // miliseconds to date convert one time
                let milli=AddwarningType[i].stringValue
                print(milli,"milliseconds")
                let Doublmillisecond = Double(milli)
                
                let onetime = Date(timeIntervalSince1970: (Doublmillisecond! / 1000.0))
                let daformatter = DateFormatter()
                daformatter.dateFormat = "HH:mm"
                daformatter.timeStyle = .short
                print("onetime",daformatter.string(from: onetime as Date))
                
                if AddwarningType.count == 1 {
                    oneTimeTf.text = "\(daformatter.string(from: onetime as Date ))"
                }
                else {
                    if i == 0 {
                        alert1Tf.text = "\(daformatter.string(from: onetime as Date ))"
                    }
                    else if i == 1 {
                        alert2Tf.text = "\(daformatter.string(from: onetime as Date ))"
                    }
                    else if i == 2 {
                        alert3Tf.text = "\(daformatter.string(from: onetime as Date ))"
                    }
                }
            }
            
            
            instanceTF.text = addWarningData[0]["Instance"].stringValue
            detailTF.text = addWarningData[0]["WarningDetails"].stringValue
            alertTF.text = addWarningData[0]["AlertChannel"].stringValue
            paymentTF.text = addWarningData[0]["PaymentChannel"].stringValue
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if paymentTF.text == "Paypal" {
        //            Payment = ["Paypal","Mobile Money"]
        //        }
        //        else {
        //            Payment = ["Mobile Money","Paypal"]
        //        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("FillData"), object: nil)
    }
    
    @objc func reloadaction(notification: Notification) {
        let dict = notification.object as! String
        print("dict ",dict)
        alertTF.text = dict
    }
    
    
    @IBAction func dateEntered(_ sender: UITextField) {
        
        if sender.text == nil || sender.text == "" {
            dateLabel.textColor = .black
        }
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
        
        
        let date = calendar.date(from: dateComponents)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
        let realMonth = Int(dateFormatter.string(from: date))
        if realMonth == nil || realMonth! != self.mm {
            dateLabel.textColor = .red  // For 29/2 on a non-leap year
        } else {
            dateLabel.textColor = .black
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        
        
        // date to milliseconds
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        let nowDouble = date.timeIntervalSince1970
        expirydateinmili = Int(nowDouble*1000)
        print("expirydateinmili",expirydateinmili)
        
        // int to string
        expirydateinmiliString = String(expirydateinmili)
        print("expirydateinmiliString",expirydateinmiliString)
        
    }
    
    @IBAction func onetimeDate(_ sender: UITextField) {
        
        if sender.text == nil || sender.text == "" {
            oneTimeDateLbl.textColor = .black
        }
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
        
        let date = calendar.date(from: dateComponents)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
        let realMonth = Int(dateFormatter.string(from: date))
        if realMonth == nil || realMonth! != self.mm {
            oneTimeDateLbl.textColor = .red  // For 29/2 on a non-leap year
        } else {
            oneTimeDateLbl.textColor = .black
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        oneTimeDateLbl.text = dateFormatter.string(from: date)
        print("oneTimeDateLbl",oneTimeDateLbl!)
        
        //        // date to milliseconds
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        //        oneTimeDateLbl.text = dateFormatter.string(from: date)
        //        let nowDouble = date.timeIntervalSince1970
        //        oneTimeDateMili = Int(nowDouble*1000)
        //        print("oneTimeDateMili",oneTimeDateMili)
        
    }
    
    //    @IBAction func onetime(_ sender: UITextField) {
    
    //        if sender.text == nil || sender.text == "" {
    //            oneTimeLbl.textColor = .black
    //        }
    //
    //        let calendar = Calendar.current
    //        let dateComponents = DateComponents(calendar: calendar, hour: self.hh, minute: self.mn)
    //
    //        let date = calendar.date(from: dateComponents)!
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "HH:mm"
    //        let realMonth = Int(dateFormatter.string(from: date))
    //        if realMonth == nil || realMonth! != self.mm {
    //            oneTimeLbl.textColor = .red
    //        } else {
    //            oneTimeLbl.textColor = .black
    //        }
    //
    //        dateFormatter.dateFormat = "HH:mm"
    //        oneTimeLbl.text = dateFormatter.string(from: date)
    //        print("oneTimeLbl",oneTimeLbl!)
    //    }
    
    @IBAction func alert1Date(_ sender: UITextField) {
        
        if sender.text == nil || sender.text == "" {
            alert1DateLbl.textColor = .black
        }
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
        
        let date = calendar.date(from: dateComponents)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
        let realMonth = Int(dateFormatter.string(from: date))
        if realMonth == nil || realMonth! != self.mm {
            alert1DateLbl.textColor = .red  // For 29/2 on a non-leap year
        } else {
            alert1DateLbl.textColor = .black
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        alert1DateLbl.text = dateFormatter.string(from: date)
        print("alert1DateLbl",alert1DateLbl!)
        
        //        // date to milliseconds
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        //        alert1DateLbl.text = dateFormatter.string(from: date)
        //        let nowDouble = date.timeIntervalSince1970
        //        alert1mili = Int(nowDouble*1000)
        //        print("alert1mili",alert1mili)
        
    }
    
    
    @IBAction func alert2date(_ sender: UITextField) {
        
        if sender.text == nil || sender.text == "" {
            alert2DateLbl.textColor = .black
        }
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
        
        let date = calendar.date(from: dateComponents)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
        let realMonth = Int(dateFormatter.string(from: date))
        if realMonth == nil || realMonth! != self.mm {
            alert2DateLbl.textColor = .red  // For 29/2 on a non-leap year
        } else {
            alert2DateLbl.textColor = .black
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        alert2DateLbl.text = dateFormatter.string(from: date)
        print("alert2DateLbl",alert2DateLbl!)
        
        //        // date to milliseconds
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        //        alert2DateLbl.text = dateFormatter.string(from: date)
        //        let nowDouble = date.timeIntervalSince1970
        //        alert2mili = Int(nowDouble*1000)
        //        print("alert2mili",alert2mili)
    }
    
    
    
    @IBAction func alert3Date(_ sender: UITextField) {
        
        if sender.text == nil || sender.text == "" {
            alert3DateLbl.textColor = .black
        }
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: self.yyyy, month: self.mm, day: self.dd)
        
        let date = calendar.date(from: dateComponents)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // Just get the month, for leap year verification
        let realMonth = Int(dateFormatter.string(from: date))
        if realMonth == nil || realMonth! != self.mm {
            alert3DateLbl.textColor = .red  // For 29/2 on a non-leap year
        } else {
            alert3DateLbl.textColor = .black
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        alert3DateLbl.text = dateFormatter.string(from: date)
        print("alert3DateLbl",alert3DateLbl!)
        
        //        // date to milliseconds
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        //        alert3DateLbl.text = dateFormatter.string(from: date)
        //        let nowDouble = date.timeIntervalSince1970
        //        alert3mili = Int(nowDouble*1000)
        //        print("alert3mili",alert3mili)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == dateTF {
            
            var isValid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = dateTF.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    isValid = ((dateTF.text!.count <= 1 && newValue >= 1) || (dateTF.text!.count == 0 && newValue <= 3)) && newValue <= 31
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
                let newString = String((dateTF.text! + string).dropFirst(3))  // removes 'DD/'
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
                let newString = String((dateTF.text! + string).dropFirst(6))  // removes 'DD/mm/'
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
                dateTF.text = String((dateTF.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    dateTF.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    dateTF.text = textField.text! + string + ""
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
                dateEntered(textField)
                textField.resignFirstResponder()
                return false
            }
            
        }
        
        if textField == oneTimeDateTf {
            
            var Valid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = oneTimeDateTf.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    Valid = ((oneTimeDateTf.text!.count <= 1 && newValue >= 1) || (oneTimeDateTf.text!.count == 0 && newValue <= 3)) && newValue <= 31
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
                let newString = String((oneTimeDateTf.text! + string).dropFirst(3))  // removes 'DD/'
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
                let newString = String((oneTimeDateTf.text! + string).dropFirst(6))  // removes 'DD/mm/'
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
                oneTimeDateTf.text = String((oneTimeDateTf.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    oneTimeDateTf.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    oneTimeDateTf.text = textField.text! + string + ""
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
                onetimeDate(textField)
                textField.resignFirstResponder()
                return false
            }
            
        }
        
        if textField == alert1DateTf {
            
            var isValid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = alert1DateTf.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    isValid = ((alert1DateTf.text!.count <= 1 && newValue >= 1) || (alert1DateTf.text!.count == 0 && newValue <= 3)) && newValue <= 31
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
                let newString = String((alert1DateTf.text! + string).dropFirst(3))  // removes 'DD/'
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
                let newString = String((alert1DateTf.text! + string).dropFirst(6))  // removes 'DD/mm/'
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
                alert1DateTf.text = String((alert1DateTf.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    alert1DateTf.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    alert1DateTf.text = textField.text! + string + ""
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
                alert1Date(textField)
                textField.resignFirstResponder()
                return false
            }
            
        }
        
        
        if textField == alert2DateTf {
            
            var isValid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = alert2DateTf.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    isValid = ((alert2DateTf.text!.count <= 1 && newValue >= 1) || (alert2DateTf.text!.count == 0 && newValue <= 3)) && newValue <= 31
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
                let newString = String((alert2DateTf.text! + string).dropFirst(3))  // removes 'DD/'
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
                let newString = String((alert2DateTf.text! + string).dropFirst(6))  // removes 'DD/mm/'
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
                alert2DateTf.text = String((alert2DateTf.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    alert2DateTf.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    alert2DateTf.text = textField.text! + string + ""
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
                alert2date(textField)
                textField.resignFirstResponder()
                return false
            }
            
        }
        
        
        if textField == alert3DateTf {
            
            var isValid = true
            
            if textField.text!.count <= 1 { // Just 1 char max has been typed, we analyse the next one typed (string)
                // if we had dd/ already, count >= 2, not this case
                let newString = alert3DateTf.text! + string // backspace inserts nothing
                if let newValue = Int(newString) {  // So we typed something in newString and it is a valid number
                    // a valid dd is always between 1 and 31
                    // But if textField.text!.count == 0, first char may be 0, waiting for the second
                    isValid = ((alert3DateTf.text!.count <= 1 && newValue >= 1) || (alert3DateTf.text!.count == 0 && newValue <= 3)) && newValue <= 31
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
                let newString = String((alert3DateTf.text! + string).dropFirst(3))  // removes 'DD/'
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
                let newString = String((alert3DateTf.text! + string).dropFirst(6))  // removes 'DD/mm/'
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
                alert3DateTf.text = String((alert3DateTf.text?.dropLast(3)) ?? "")
                return false
            }
            if (textField.text?.count == 1) || (textField.text?.count == 4) {
                if string != "" {
                    // We did not type a backspace after d or after dd/m: we add the typed char (string) and a new '/' separator
                    alert3DateTf.text = textField.text! + string + "/"
                    return false
                }
            } else if (textField.text?.count == 9) {
                // We have dd/mm/yyy and typed a new char
                if string != "" {   // Not a backspace: let's add " " after yyyy
                    alert3DateTf.text = textField.text! + string + ""
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
                alert3Date(textField)
                textField.resignFirstResponder()
                return false
            }
            
        }
        
        //         if textField == oneTimeTf {
        //
        //             var isValid = true
        //
        //             if textField.text!.count >= 0  && textField.text!.count <= 1 {  // Between 11 and 12 char max have been typed or inserted (dd/mm/yyyy  to dd/mm/yyyy h), we analyse the next one typed (string)
        //                         // backspace inserts nothing: string is ""
        //                         // Is hh Valid ?
        //                         let newString = String((oneTimeTf.text! + string).dropFirst(0))  // removes 'DD/MM/YYYY '
        //                         if string == "" { // case of backspace
        //                             // skip if we typed backspace after a space
        //                             // isValid remains true, we do nothing
        //                         } else {  // we had txtValue.text! + string = dd/mm/yyyy_ and something
        //                             if let newValue = Int(newString) {
        //                                 // So we typed something in hh:mm (newString) and it is a valid number
        //                                 // a valid hh must be between 0 and 23
        //                                 // if textField.text!.count == 11, first char of newString can be 0, waiting for the second
        //                                 isValid = newValue >= 0 && newValue <= 23
        //                                 self.hh = newValue
        //
        //                                 // If we have typed a complete hh, is it a valid hour ?  backspace remains possible
        //                             } else {
        //                                 isValid = false // yyyy Not a number
        //                             }
        //                             if !isValid {
        //                                 return false
        //                             }
        //                         }
        //                     } else if textField.text!.count >= 3  && textField.text!.count <= 4 {  // Between 14 and 15 char max have been typed or inserted (dd/mm/yyyy hh: to dd/mm/yyyy hh:m), we analyse the next one typed (string)
        //                         // backspace inserts nothing: string is ""
        //                         // Is mn Valid ?
        //                         let newString = String((oneTimeTf.text! + string).dropFirst(3))  // removes 'DD/MM/YYYY hh:'
        //                         if string == "" { // case of backspace
        //                             // skip if we typed backspace after a :
        //                             // isValid remains true, we do nothing
        //                         } else {  // we had txtValue.text! + string = dd/mm/yyyy hh: and something
        //                             if let newValue = Int(newString) {
        //                                 // So we typed something in hh:mm (newString) and it is a valid number
        //                                 // a valid hh must be between 0 and 59
        //                                 // if textField.text!.count == 14, first char of newString can be 0, waiting for the second
        //                                 isValid = newValue >= 0 && newValue <= 59
        //                                 self.mn = newValue
        //
        //                                 // If we have typed a complete mn, is it a valid minuyes number ?  backspace remains possible
        //                             } else {
        //                                 isValid = false // yyyy Not a number
        //                             }
        //                             if !isValid {
        //                                 return false
        //                             }
        //                         }
        //                     }
        //             //Handle backspace being pressed : string.count == 0
        //                    // We remove the special character that was added plus the new that was typed
        //                    if string.count == 0 && (textField.text?.last == ":") {
        //                        oneTimeTf.text = String((oneTimeTf.text?.dropLast(2)) ?? "")
        //                        return false
        //                    }
        //                    else if (textField.text?.count == 1) {
        //                        // We have dd/mm/yyyy h and typed a new char
        //                        if string != "" {  // Not a backspace: let's add ":" after hh
        //                            oneTimeTf.text = textField.text! + string + ":"
        //                            return false
        //                        }
        //                    }
        //                    if string == "\t" && textField.text!.count >= 3 {  // "Tab": we force exit
        //                        onetime(textField)
        //                        textField.resignFirstResponder()
        //                        return false
        //                    }
        //             if string == "\n" && textField.text!.count >= 3 { return true } // We hit 'Return' at the end, with a valid date
        //
        //                     return !(textField.text!.count > 4 && (string.count) > range.length)
        //                 }
        
        if string == "\n" && textField.text!.count >= 9 { return true } // We hit 'Return' at the end, with a valid date
        
        return !(textField.text!.count > 9 && (string.count) > range.length)
        
    }
    
    
    
    @IBAction func backBtnCNW(_ sender: UIButton) {
        isClickModify = false
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
        if (((nameTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))) {
            CommonFunctions.showAlert(self, message: "Please Enter Warning Name".localiz(), title: appName)
        } else if (nameTF.text?.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Warning Name".localiz(), title: appName)
        } else if(dateTF.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            CommonFunctions.showAlert(self, message: "Please Enter Date of Expiration".localiz(), title: appName)
        } else if (dateTF.text?.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Date of Expiration".localiz(), title: appName)
        } else if isDateValid(dateTF.text!) == false {
            CommonFunctions.showAlert(self, message: "Enter Valid Expiry Date".localiz(), title: appName)
        } else if expirydateinmili < createDate  {
            CommonFunctions.showAlert(self, message: "Please Enter Future Date of Expiry".localiz(), title: appName)
        } else if(((instanceTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
        } else if (instanceTF.text?.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
        } else if(((detailTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
        } else if (detailTF.text?.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
        }
        //        else {
        //            AddWarning()
        //        }
        
        if (warningTypeTf.text == warningType[1]) {
            
            if oneTimeDateTf.text!.count > 9 && oneTimeTf.text!.count > 0 {
                //                if (warningTypeTf.text == warningType[1]) {
                // onetime warning type
                oneDateTime = oneTimeDateLbl.text! + " " + oneTimeTf.text!
                print(oneDateTime,"oneDateTime")
                
                let dayTimePeriodFormatter = DateFormatter()
                let dtStr = oneDateTime
                dayTimePeriodFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
                let combineDate = dayTimePeriodFormatter.date(from: dtStr)
                let timeintrser = combineDate?.timeIntervalSince(combineDate!)
                
                // date to milliseconds
                let nowDouble = combineDate!.timeIntervalSince1970
                oneTimeDateMilliseconds = Int(nowDouble*1000)
                print("oneTimeDateMilliseconds",oneTimeDateMilliseconds)
                // int to string
                oneTimeDateString = String(oneTimeDateMilliseconds)
                print("oneTimeDateString",oneTimeDateString)
                //                }
            }
            
            if (oneTimeDateTf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Warning Date".localiz(), title: appName)
            } else if isDateValid(oneTimeDateTf.text!) == false {
                CommonFunctions.showAlert(self, message: "Enter One Time Valid Date".localiz(), title: appName)
            } else if (oneTimeTf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter OneTime".localiz(), title: appName)
            } else if oneTimeDateMilliseconds < createDate {
                CommonFunctions.showAlert(self, message: "Please Enter Future Date of Warning".localiz(), title: appName)
            }
            else if (alertTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Choose Alert Channel".localiz(), title: appName)
            } else if (paymentTF.text!.count == 0) {
                CommonFunctions.showAlert(self, message: "Choose Payment Channel".localiz(), title: appName)
            }
            else if (nameTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Warning Name".localiz(), title: appName)
            } else if (dateTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Date of Expiration".localiz(), title: appName)
            } else if isDateValid(dateTF.text!) == false {
                CommonFunctions.showAlert(self, message: "Enter Valid Expiry Date".localiz(), title: appName)
            } else if expirydateinmili < createDate  {
                CommonFunctions.showAlert(self, message: "Please Enter Future Date of Expiry".localiz(), title: appName)
            } else if(((instanceTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
                CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
            } else if (instanceTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
            } else if(((detailTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
                CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
            } else if (detailTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
            }
            else {
                timeDateStamp.append(oneTimeDateString)
                
                
                AddWarning()
                
            }
        }
        
        //        if (warningTypeTf.text == warningType[0]) {
        
        if (warningTypeTf.text == warningType[0]) {
            if alert1DateTf.text!.count > 9 && alert1Tf.text!.count > 0 {
                //alert 1 recurring
                alertDateTime1 = alert1DateLbl.text! + " " + alert1Tf.text!
                print(alertDateTime1,"alertDateTime1")
                
                let alert1 = DateFormatter()
                let dtStr1 = alertDateTime1
                alert1.dateFormat = "dd/MM/yyyy hh:mm a"
                let combineDate1 = alert1.date(from: dtStr1)
                let timeintrser1 = combineDate1?.timeIntervalSince(combineDate1!)
                
                // date to milliseconds
                let nowDouble1 = combineDate1!.timeIntervalSince1970
                alertDateTime1Mili1 = Int(nowDouble1*1000)
                print("alertDateTime1Mili1",alertDateTime1Mili1)
                // int to string
                alertDateTime1String = String(alertDateTime1Mili1)
                print("alertDateTime1String",alertDateTime1String)
                //               timeDateStamp.append(alertDateTime1String)
            }
            if alert2DateTf.text!.count > 9 && alert2Tf.text!.count > 0 {
                //alert 2 recurring
                alertDateTime2 = alert2DateLbl.text! + " " + alert2Tf.text!
                print(alertDateTime2,"alertDateTime2")
                
                let alert2 = DateFormatter()
                let dtStr2 = alertDateTime2
                alert2.dateFormat = "dd/MM/yyyy hh:mm a"
                let combineDate2 = alert2.date(from: dtStr2)
                let timeintrser2 = combineDate2?.timeIntervalSince(combineDate2!)
                
                // date to milliseconds
                let nowDouble2 = combineDate2!.timeIntervalSince1970
                alertDateTime1Mili2 = Int(nowDouble2*1000)
                print("alertDateTime1Mili2",alertDateTime1Mili2)
                // int to string
                alertDateTime2String = String(alertDateTime1Mili2)
                print("alertDateTime2String",alertDateTime2String)
                //               timeDateStamp.append("," + alertDateTime2String + ",")
            }
            if alert3DateTf.text!.count > 9 && alert3Tf.text!.count > 0  {
                //alert 3 recurring
                alertDateTime3 = alert3DateLbl.text! + " " + alert3Tf.text!
                print(alertDateTime3,"alertDateTime3")
                
                let alert3 = DateFormatter()
                let dtStr3 = alertDateTime3
                alert3.dateFormat = "dd/MM/yyyy hh:mm a"
                let combineDate3 = alert3.date(from: dtStr3)
                let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
                
                // date to milliseconds
                let nowDouble3 = combineDate3!.timeIntervalSince1970
                alertDateTime1Mili3 = Int(nowDouble3*1000)
                print("alertDateTime1Mili3",alertDateTime1Mili3)
                // int to string
                alertDateTime3String = String(alertDateTime1Mili3)
                print("alertDateTime3String",alertDateTime3String)
                //               timeDateStamp.append(alertDateTime3String)
            }
            //            }
            
            if (alert1DateTf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 1 Date".localiz(), title: appName)
            } else if isDateValid(alert1DateTf.text!) == false {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 1 Valid Date".localiz(), title: appName)
            } else if (alert1Tf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 1 Time".localiz(), title: appName)
            } else if (alertDateTime1Mili1 < createDate) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 1 Future Date".localiz(), title: appName)
            }
            else if (alert2DateTf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 2 Date".localiz(), title: appName)
            } else if isDateValid(alert2DateTf.text!) == false {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 2 Valid Date".localiz(), title: appName)
            } else if (alert2Tf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 2 Time".localiz(), title: appName)
            } else if alertDateTime1Mili2 < createDate {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 2 Future Date".localiz(), title: appName)
            }
            else if (alert3DateTf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 3 Date".localiz(), title: appName)
            } else if isDateValid(alert3DateTf.text!) == false {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 3 Valid Date".localiz(), title: appName)
            } else if (alert3Tf.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 3 Time".localiz(), title: appName)
            }else if alertDateTime1Mili3 < createDate {
                CommonFunctions.showAlert(self, message: "Please Enter Alert 3 Future Date".localiz(), title: appName)
            }
            else if (alertTF.text!.count == 0) {
                CommonFunctions.showAlert(self, message: "Choose Alert Channel".localiz(), title: appName)
            } else if (paymentTF.text!.count == 0) {
                CommonFunctions.showAlert(self, message: "Choose Payment Channel".localiz(), title: appName)
            } else if (nameTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Warning Name".localiz(), title: appName)
            } else if (dateTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Date of Expiration".localiz(), title: appName)
            } else if isDateValid(dateTF.text!) == false {
                CommonFunctions.showAlert(self, message: "Enter Valid Expiry Date".localiz(), title: appName)
            } else if expirydateinmili < createDate  {
                CommonFunctions.showAlert(self, message: "Please Enter Future Date of Expiry".localiz(), title: appName)
            } else if(((instanceTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
                CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
            } else if (instanceTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Instance".localiz(), title: appName)
            } else if(((detailTF.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
                CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
            } else if (detailTF.text?.count == 0) {
                CommonFunctions.showAlert(self, message: "Please Enter Warning Detail".localiz(), title: appName)
            }
            else {
                timeDateStamp.append(alertDateTime1String)
                timeDateStamp.append("," + alertDateTime2String + ",")
                timeDateStamp.append(alertDateTime3String)
                
                AddWarning()
                
            }
        }
        
        //        else if (warningTypeTf.text == warningType[0]) {
        //            CommonFunctions.showAlert(self, message: "Please Select Warning Type", title: appName)
        //        }
        //
    }
    
    func isDateValid(_ date : String) -> Bool{
        let dateTest = NSPredicate(format: "SELF MATCHES %@", "[0-9]{2}[-|/]{1}[0-9]{2}[-|/]{1}[0-9]{4}")
        return dateTest.evaluate(with: date)
    }
    
    
    //Mark:- AddWarning Api
    func AddWarning() {
        isClickModify = false
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().AddWarning(Id: addWarningId, UserId: "\(DataManager.UserId!)", WarningName: nameTF.text!, ExpirationDate: expirydateinmiliString, Instance: instanceTF.text!, AlertChannel:alertTF.text!, PaymentChannel: paymentTF.text!, WarningDetails: detailTF.text!, BillingMethod: "", IsWarningType: otherservicelblName, IsDropWarning: false, CreatedDate: "\(createDate)", WarningTypeDateTime: timeDateStamp, currentVC: self ) {
            
            (response) in
            
            print("addWarningResponse",response)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentAccountViewController") as! MyCurrentAccountViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            CommonFunctions.dismissProgressView(view: self.view)
        }
    }
    
    
    
    @IBAction func cancleBtn(_ sender: UIButton) {
        isClickModify = false
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func alertAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertPopupVC") as! AlertPopupVC
        vc.channelString = alertTF.text!
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.oneTimeTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeStyle = .short
            self.oneTimeTf.text = dateFormatter.string(from: datePicker.date)
            print(oneTimeTf!,"oneTimeTf")
            //                // date to milliseconds
            //                dateFormatter.dateFormat = "HH:mm"
            //                oneTimeTf.text = dateFormatter.string(from: datePicker.date)
            //                let nowDouble = datePicker.date.timeIntervalSince1970
            //                print(nowDouble,"nowDouble")
            //                oneTimeMilli = Int(nowDouble*1000)
            //                print("oneTimeMilli",oneTimeMilli)
        }
        self.oneTimeTf.resignFirstResponder()
    }
    
    @objc func alert1doneButtonPressed() {
        if let  datePicker = self.alert1Tf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeStyle = .short
            self.alert1Tf.text = dateFormatter.string(from: datePicker.date)
            
            //            // date to milliseconds
            //            dateFormatter.dateFormat = "HH:mm"
            //            alert1Tf.text = dateFormatter.string(from: datePicker.date)
            //            let nowDouble = datePicker.date.timeIntervalSince1970
            //            alert1TimeMili = Int(nowDouble*1000)
            //            print("alert1TimeMili",alert1TimeMili)
        }
        self.alert1Tf.resignFirstResponder()
    }
    
    @objc func alert2doneButtonPressed() {
        if let  datePicker = self.alert2Tf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeStyle = .short
            self.alert2Tf.text = dateFormatter.string(from: datePicker.date)
            
            //            // date to milliseconds
            //            dateFormatter.dateFormat = "HH:mm"
            //            alert2Tf.text = dateFormatter.string(from: datePicker.date)
            //            let nowDouble = datePicker.date.timeIntervalSince1970
            //            alert2TimeMili = Int(nowDouble*1000)
            //            print("alert2TimeMili",alert2TimeMili)
        }
        self.alert2Tf.resignFirstResponder()
    }
    
    @objc func alert3doneButtonPressed() {
        if let  datePicker = self.alert3Tf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeStyle = .short
            self.alert3Tf.text = dateFormatter.string(from: datePicker.date)
            
            //            // date to milliseconds
            //            dateFormatter.dateFormat = "HH:mm"
            //            alert3Tf.text = dateFormatter.string(from: datePicker.date)
            //            let nowDouble = datePicker.date.timeIntervalSince1970
            //            alert3TimeMili = Int(nowDouble*1000)
            //            print("alert3TimeMili",alert3TimeMili)
        }
        self.alert3Tf.resignFirstResponder()
    }
    
    @objc func expiryDatePickerTfDone() {
        if let  datePicker = self.expiryDatePickerTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMM/yyyy"
            dateFormatter.dateStyle = .medium
            
            //            let datestring = dateFormatter.string(from: datePicker.date)
            //            let string = (datestring as NSString).substring(with: NSMakeRange(3, 3))
            //            print("string",string)
            
            //            self.dateTF.text = dateFormatter.string(from: datePicker.date)
            //            self.dateLabel.text = dateFormatter.string(from: datePicker.date)
            let expiry = dateFormatter.string(from: datePicker.date)
            print("expiry",expiry)
            let nowDouble3 = datePicker.date.timeIntervalSince1970
            let expi = Int(nowDouble3*1000)
            print("expirymilli",expi)
            expirydateinmili = expi
            
            //            if string == "Sep" {
            //                var datestring = dateFormatter.string(from: datePicker.date)
            //                datestring = datestring.replacingOccurrences(of: "Sep", with: "09")
            //                print("datestring",datestring)
            //            }
            
            //            // date to milliseconds
            //            let dtStr3 = expiry
            //            dateFormatter.dateFormat = "dd/MM/yyyy"
            //            let combineDate3 = dateFormatter.date(from: dtStr3)
            //            let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
            //            let nowDouble3 = combineDate3!.timeIntervalSince1970
            //            let expi = Int(nowDouble3*1000)
            //            print("expirymilli",expi)
            //            expirydateinmili = expi
            //
            
            
            
            // int to string
            expirydateinmiliString = String(expi)
            print("newDateExpiryString",expirydateinmiliString)
            
            //milliseconds to date
            let milliseconds=expi
            print(milliseconds,"milliseconds")
            let Doublemilliseconds = Double(milliseconds)
            let Expirydate = Date(timeIntervalSince1970: (Doublemilliseconds / 1000.0))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            print("Expirydate",formatter.string(from: Expirydate as Date))
            dateTF.text = "\(formatter.string(from: Expirydate as Date ))"
            dateLabel.text = "\(formatter.string(from: Expirydate as Date ))"
            
            
        }
        self.expiryDatePickerTf.resignFirstResponder()
    }
    
    @objc func oneDatePickerTfDone() {
        if let  datePicker = self.oneDatePickerTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .medium
            
            let oneDate = dateFormatter.string(from: datePicker.date)
            print("oneDate",oneDate)
            
            // date to milliseconds
            //            let dtStr3 = oneDate
            //            dateFormatter.dateFormat = "dd/MM/yyyy"
            //            let combineDate3 = dateFormatter.date(from: dtStr3)
            //            let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
            //            let nowDouble3 = combineDate3!.timeIntervalSince1970
            //            let one = Int(nowDouble3*1000)
            //            print("oneDate",one)
            //            oneTimeDateMilliseconds = one
            
            
            let expiry = dateFormatter.string(from: datePicker.date)
            print("expiry",expiry)
            let nowDouble3 = datePicker.date.timeIntervalSince1970
            let one = Int(nowDouble3*1000)
            print("oneDate",one)
            oneTimeDateMilliseconds = one
            
            
            // int to string
            oneTimeDateString = String(one)
            print("oneTimeDateString",oneTimeDateString)
            
            //milliseconds to date
            let milliseconds=one
            print(milliseconds,"milliseconds")
            let Doublemilliseconds = Double(milliseconds)
            let onedate = Date(timeIntervalSince1970: (Doublemilliseconds / 1000.0))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            print("OneDate",formatter.string(from: onedate as Date))
            oneTimeDateTf.text = "\(formatter.string(from: onedate as Date ))"
            oneTimeDateLbl.text = "\(formatter.string(from: onedate as Date ))"
            
        }
        self.oneDatePickerTf.resignFirstResponder()
    }
    
    @objc func alert1DatePickerTfDone() {
        if let  datePicker = self.alert1DatePickerTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .medium
            
            let alert1 = dateFormatter.string(from: datePicker.date)
            print("alert1",alert1)
            
            // date to milliseconds
            //            let dtStr3 = alert1
            //            dateFormatter.dateFormat = "dd/MM/yyyy"
            //            let combineDate3 = dateFormatter.date(from: dtStr3)
            //            let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
            //            let nowDouble3 = combineDate3!.timeIntervalSince1970
            //            let alertD1 = Int(nowDouble3*1000)
            //            print("alertD1",alertD1)
            //            alertDateTime1Mili1 = alertD1
            
            let expiry = dateFormatter.string(from: datePicker.date)
            print("expiry",expiry)
            let nowDouble3 = datePicker.date.timeIntervalSince1970
            let alertD1 = Int(nowDouble3*1000)
            print("alertD1",alertD1)
            alertDateTime1Mili1 = alertD1
            
            // int to string
            alertDateTime1String = String(alertD1)
            print("alertDateTime1String",alertDateTime1String)
            
            //milliseconds to date
            let milliseconds=alertD1
            print(milliseconds,"milliseconds")
            let Doublemilliseconds = Double(milliseconds)
            let onedate = Date(timeIntervalSince1970: (Doublemilliseconds / 1000.0))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            print("alertD1",formatter.string(from: onedate as Date))
            alert1DateTf.text = "\(formatter.string(from: onedate as Date ))"
            alert1DateLbl.text = "\(formatter.string(from: onedate as Date ))"
            
        }
        self.alert1DatePickerTf.resignFirstResponder()
    }
    
    @objc func alert2DatePickerTfDone() {
        if let  datePicker = self.alert2DatePickerTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .medium
            
            let alert2 = dateFormatter.string(from: datePicker.date)
            print("alert2",alert2)
            
            // date to milliseconds
            //            let dtStr3 = alert2
            //            dateFormatter.dateFormat = "dd/MM/yyyy"
            //            let combineDate3 = dateFormatter.date(from: dtStr3)
            //            let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
            //            let nowDouble3 = combineDate3!.timeIntervalSince1970
            //            let alertD2 = Int(nowDouble3*1000)
            //            print("alertD2",alertD2)
            //            alertDateTime1Mili2 = alertD2
            
            let expiry = dateFormatter.string(from: datePicker.date)
            print("expiry",expiry)
            let nowDouble3 = datePicker.date.timeIntervalSince1970
            let alertD2 = Int(nowDouble3*1000)
            print("alertD2",alertD2)
            alertDateTime1Mili2 = alertD2
            
            // int to string
            alertDateTime2String = String(alertD2)
            print("alertDateTime2String",alertDateTime2String)
            
            //milliseconds to date
            let milliseconds=alertD2
            print(milliseconds,"milliseconds")
            let Doublemilliseconds = Double(milliseconds)
            let onedate = Date(timeIntervalSince1970: (Doublemilliseconds / 1000.0))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            print("alertD1",formatter.string(from: onedate as Date))
            alert2DateTf.text = "\(formatter.string(from: onedate as Date ))"
            alert2DateLbl.text = "\(formatter.string(from: onedate as Date ))"
            
        }
        self.alert2DatePickerTf.resignFirstResponder()
    }
    
    @objc func alert3DatePickerTfDone() {
        if let  datePicker = self.alert3DatePickerTf.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .medium
            
            let alert3 = dateFormatter.string(from: datePicker.date)
            print("alert3",alert3)
            
            // date to milliseconds
            //            let dtStr3 = alert3
            //            dateFormatter.dateFormat = "dd/MM/yyyy"
            //            let combineDate3 = dateFormatter.date(from: dtStr3)
            //            let timeintrser3 = combineDate3?.timeIntervalSince(combineDate3!)
            //            let nowDouble3 = combineDate3!.timeIntervalSince1970
            //            let alertD3 = Int(nowDouble3*1000)
            //            print("alertD3",alertD3)
            //            alertDateTime1Mili3 = alertD3
            
            let expiry = dateFormatter.string(from: datePicker.date)
            print("expiry",expiry)
            let nowDouble3 = datePicker.date.timeIntervalSince1970
            let alertD3 = Int(nowDouble3*1000)
            print("alertD3",alertD3)
            alertDateTime1Mili3 = alertD3
            
            // int to string
            alertDateTime3String = String(alertD3)
            print("alertDateTime3String",alertDateTime3String)
            
            //milliseconds to date
            let milliseconds=alertD3
            print(milliseconds,"milliseconds")
            let Doublemilliseconds = Double(milliseconds)
            let onedate = Date(timeIntervalSince1970: (Doublemilliseconds / 1000.0))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            print("alertD3",formatter.string(from: onedate as Date))
            alert3DateTf.text = "\(formatter.string(from: onedate as Date ))"
            alert3DateLbl.text = "\(formatter.string(from: onedate as Date ))"
            
            
        }
        self.alert3DatePickerTf.resignFirstResponder()
    }
    
}


extension CreateNewWarningViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView2 {
            return Payment.count
        } else {
            return warningType.count
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView2 {
            return Payment[row]
        }
        else  {
            return warningType[row]
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView2 {
            
            if Payment[row] == Payment[0] {
                paymentTF.text = "\(Payment[0])"
            } else {
                //                Payment[row] == Payment[1]
                paymentTF.text = "\(Payment[1])"
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PayPopupVC") as! PayPopupVC
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: false, completion: nil)
                
                paymentTF.resignFirstResponder()
            }
            //            paymentTF.text = "\(Payment[row])"
            self.view.endEditing(false)
            
        } else {
            //            if warningType[row] == warningType[0] {
            //                selectWarning.constant = 0
            //                oneTimeHeight.constant = 0
            //                recurringHeight.constant = 0
            //                alert1Height.constant = 0
            //                alert2Height.constant = 0
            //                alert3Height.constant = 0
            //            } else
            if warningType[row] == warningType[1] {
                oneTimeVw.isHidden = false
                recurringVw.isHidden = true
                selectWarning.constant = 80
                oneTimeHeight.constant = 61
                recurringHeight.constant = 0
                alert1Height.constant = 0
                alert2Height.constant = 0
                alert3Height.constant = 0
            } else if warningType[row] == warningType[0]{
                oneTimeHeight.constant = 0
                recurringVw.isHidden = false
                oneTimeVw.isHidden = true
                selectWarning.constant = 230
                recurringHeight.constant = 191
                alert1Height.constant = 55
                alert2Height.constant = 55
                alert3Height.constant = 55
            }
            warningTypeTf.text = "\(warningType[row])"
        }
    }
}

extension UITextField {
    
    func addInputDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .time
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
        let cancelBarButton = UIBarButtonItem(title: "Cancel".localiz(), style: .plain, target: self, action: #selector(cancelPress))
        let doneBarButton = UIBarButtonItem(title: "Done".localiz(), style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPress() {
        self.resignFirstResponder()
    }
    
}
