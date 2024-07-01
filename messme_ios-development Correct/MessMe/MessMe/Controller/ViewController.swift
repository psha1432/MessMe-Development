//
//  ViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit
import IQKeyboardManagerSwift
import LanguageManager_iOS

class ViewController: UIViewController {
    
    @IBOutlet weak var addViewVC: UIView!
    @IBOutlet weak var loginMyAccount: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var chooseLang: UITextField!
    
    
    var langType = ["English","Français"]
    var pickerView = UIPickerView()
    var isLangBtnPressedInVC = Bool()
    
    @IBOutlet weak var txtInfo: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var languageType = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        chooseLang.inputView = pickerView
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        SharedAppDelegate.languageButtonAction()
//        CommonFunctions.updateLangugaeStrings()
        
        if DataManager.Language == "fr" {
            chooseLang.text = langType[1]
            langType = ["Français","English"]
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Fait".localiz()
        }
        else {
            chooseLang.text = langType[0]
            langType = ["English","Français"]
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localiz()
        }
    }
    
    
    @IBAction func loginMyAccount(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createAccountBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //Mark:- Change User Language
//    func languageButtonAction(langCode: String) {
//        // This is done so that network calls now have the Accept-Language as "hi" (Using Alamofire) Check if you can remove these
//        UserDefaults.standard.set(["\(langCode)"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//
//        // Update the language by swaping bundle
//        Bundle.setLanguage("\(langCode)")
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        vc.modalPresentationStyle = .fullScreen
//
//        if langType[1] == "Français" {
//        vc.languageType = "Français"
//
//        } else {
//            vc.languageType = "English"
//        }
//        vc.isLangBtnPressedInVC = true
//        self.navigationController?.pushViewController(vc, animated: false)
//
//    }
    
    //Mark:- Change User Language
        func languageButtonAction(langCode: String) {
            
            print(langCode);
            
            DataManager.Language = langCode
            let selectedLanguage: Languages = langCode == "fr" ? .fr : .en
            
            LanguageManager.shared.setLanguage(language: selectedLanguage) { title -> UIViewController in
              print("title of the scene: \(title ?? "")")
              return self.viewControllerToShow()
                
            } animation: { view in
              // Do custom animation
              view.transform = CGAffineTransform(scaleX: 2, y: 2)
              view.alpha = 0
            }
        
        }
    
    private func viewControllerToShow() -> UIViewController {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          return storyboard.instantiateInitialViewController()!
        }
    
}



extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return langType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if langType[row] == "Français" {
            chooseLang.text = langType[1]
            DataManager.Language = "fr"
           
            self.languageButtonAction(langCode: "fr")
        } else {
            chooseLang.text = langType[0]
            DataManager.Language = "English"
         
            self.languageButtonAction(langCode: "en")
        }
        
        chooseLang.resignFirstResponder()
//        chooseLang.text = "\(langType[row])"
    }
    
}

//extension String {
//    func localizableString(loc: String) -> String{
//        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//    }
//}

