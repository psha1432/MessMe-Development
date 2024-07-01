//
//  MyCurrentAccountViewController.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

import UIKit

class MyCurrentAccountViewController: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    
    var GetMyWarningListResponse = [JSON]()
    var backgroundView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetMyWarningList()
    }
    
    @IBAction func backBtnMCA(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Mark:- GetMyWarningList Api
    func GetMyWarningList() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().GetMyWarningList(UserId: DataManager.UserId!, currentVC: self) { (response) in
            
            print("GetMyWarningList response",response)
            
            let dataArray = response["data"].arrayValue
            print("dataArray", dataArray)
            //            GetMyWarningListResponse.removeAll()
            self.GetMyWarningListResponse = dataArray
            
            self.tableVw.reloadData()
            
            CommonFunctions.dismissProgressView(view: self.view)
            
        }
    }
    
    
    @IBAction func addNewWarningBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWarningViewController") as! CreateNewWarningViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MyCurrentAccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if GetMyWarningListResponse.count != 0
        {
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "You have no active warning"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetMyWarningListResponse.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DolorSitCell", for: indexPath) as! DolorSitCell
        
        cell.currentWarningListLbl.text = GetMyWarningListResponse[indexPath.row]["WarningName"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = GetMyWarningListResponse[indexPath.row]
        let categoryArray = dict
        let Id = categoryArray["Id"].intValue
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentWarningVC") as! MyCurrentWarningVC
        DataManager.Id = categoryArray["Id"].intValue
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


class DolorSitCell: UITableViewCell {
    
    @IBOutlet weak var currentWarningListLbl: UILabel!
    
}
