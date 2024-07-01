//
//  MyAccountViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    @IBOutlet weak var addViewMA: UIViewCustomClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func myCurrentAccBtn(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentAccountViewController") as! MyCurrentAccountViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


    @IBAction func addNewWarningBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWarningViewController") as! CreateNewWarningViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func otherServiceBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtherServiceViewController") as! OtherServiceViewController
        vc.screenName = "MyAccountViewController"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func editProfileBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileDetailVC") as! EditProfileDetailVC
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        
        // Create the alert controller
        let alertController = UIAlertController(title: appName, message: "Are you sure?", preferredStyle: .alert)

           // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
               UIAlertAction in

               NSLog("OK Pressed")
            
            DataManager.isLogin = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
           
            self.navigationController?.pushViewController(vc, animated: true)
            
            self.showToast(message: "Sucessfully Logout", font: .systemFont(ofSize: 17.0),yAxis:560.0)
           }
        let cancelAction = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel) {
               UIAlertAction in
               NSLog("Cancel Pressed")
           }

           // Add the actions
           alertController.addAction(okAction)
           alertController.addAction(cancelAction)

           // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}


