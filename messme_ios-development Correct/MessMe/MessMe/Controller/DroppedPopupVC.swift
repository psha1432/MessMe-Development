//
//  DroppedPopupVC.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit

class DroppedPopupVC: UIViewController {
    
    @IBOutlet weak var dropBackVw: UIView!
    @IBOutlet weak var closeBtnPopup: UIViewCustomClass!
    @IBOutlet weak var dropPopup: UIViewCustomClass!
    @IBOutlet weak var lblName: UILabel!
    
    var labelName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = labelName
        dropBackVw.alpha = 0.5
        dropPopup.isHidden = false
        closeBtnPopup.isHidden = false
        dropBackVw.isHidden = false
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dropBackVw.isHidden = true
        dropPopup.isHidden = true
        closeBtnPopup.isHidden = true
        
        self.dismiss(animated: true, completion: nil)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentWarningVC") as! MyCurrentWarningVC
//        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
