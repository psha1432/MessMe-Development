//
//  AlertPopupVC.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit

class AlertPopupVC: UIViewController {
    
    @IBOutlet weak var alertBackVw: UIView!
    @IBOutlet weak var alertPopupVw: UIView!
    @IBOutlet weak var chnnlTbl: UITableView!
    
    var channelArry = ["WhatsApp","SMS","Mail","Notification"]
    var selectedChnlArray = [String]()
    var channelString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedChnlArray.removeAll()
        if channelString.count > 1 {
            selectedChnlArray = channelString.components(separatedBy: ", ")
            print("selectedChnlArray",selectedChnlArray)
        }
        chnnlTbl.reloadData()
    }
    
    @IBAction func alertCancelBtn(_ sender: UIButton) {
        alertBackVw.isHidden = true
        alertPopupVw.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func alertOkBtn(_ sender: UIButton) {
        channelString = selectedChnlArray.joined(separator:", ")
        print("channelString",channelString)
        Foundation.NotificationCenter.default.post(name: NSNotification.Name("FillData"), object: channelString)
        alertBackVw.isHidden = true
        alertPopupVw.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AlertPopupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customChnaleCell", for: indexPath) as! customChnaleCell
        
        let chnlName = channelArry[indexPath.row]
        cell.chnlLbl.text = chnlName
        if selectedChnlArray.contains(chnlName) {
            if #available(iOS 13.0, *) {
                cell.checkImg.image = UIImage(systemName: "checkmark.square")
            } else {
                // Fallback on earlier versions
            }
        }
        else {
            if #available(iOS 13.0, *) {
                cell.checkImg.image = UIImage(systemName: "square")
            } else {
                // Fallback on earlier versions
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chnlName = channelArry[indexPath.row]
        if selectedChnlArray.contains(chnlName) {
            let indexOfEl = selectedChnlArray.index(of: chnlName)
            selectedChnlArray.remove(at: indexOfEl!)
        }
        else {
            selectedChnlArray.append(channelArry[indexPath.row])
        }
        chnnlTbl.reloadData()
    }
}


class customChnaleCell: UITableViewCell {
    
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var chnlLbl: UILabel!
    
}
