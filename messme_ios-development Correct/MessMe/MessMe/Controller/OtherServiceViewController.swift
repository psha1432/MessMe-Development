//
//  OtherServiceViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit

class OtherServiceViewController: UIViewController{
    
    @IBOutlet weak var lblOS: UILabel!
    
    var label = ["Birthday", "Meeting", "Identity Card Renewal", "Passport Renewal", "Drive Licence Renewal", "Appointment", "Date Of Examination"]
    var screenName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func backBtnOS(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
    


extension OtherServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWarningCell", for: indexPath) as! NewWarningCell
        
        cell.cellLblOS.text = label[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWarningViewController") as! CreateNewWarningViewController
        
        if screenName == "MyAccountViewController" {
            vc.otherservicelblName = label[indexPath.row]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


class NewWarningCell: UITableViewCell {
    
    @IBOutlet weak var cellLblOS: UILabel!
    
}

