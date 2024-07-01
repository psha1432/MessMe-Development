//
//  MyCurrentWarningVC.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

var isClickModify = Bool()
import UIKit
import Alamofire

class MyCurrentWarningVC: UIViewController {
    
    @IBOutlet weak var warningNameLbl: UILabel!
    @IBOutlet weak var createDateLbl: UILabel!
    @IBOutlet weak var expirationDateLbl: UILabel!
    @IBOutlet weak var warningDetailLbl: UILabel!
    @IBOutlet weak var instanceLbl: UILabel!
    @IBOutlet weak var warningType: UILabel!
    @IBOutlet weak var labelHeightConstraint: NSLayoutConstraint!
    
    var MyWarningDetailsById = [JSON]()
    var militoDate = String()
    var createDate = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reloadAction),
                                               name: NSNotification.Name("ApiReload"),
                                               object: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetMyWarningDetailsById()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ApiReload"), object: nil)
    }
    
    @objc func reloadAction(notification: Notification) {
            GetMyWarningDetailsById()
        
    }
    
    
    //Mark:- GetMyWarningDetailsById Api
    func GetMyWarningDetailsById() {
        
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().GetMyWarningDetailsById(WarningId: DataManager.Id!, currentVC: self) { (response) in
            
            print("GetMyWarningDetailsById response",response)
            
            let dataArray = response["data"].arrayValue
            print("dataArray", dataArray)
            self.MyWarningDetailsById = dataArray
                     
            self.WarningDetailsData()
            
            CommonFunctions.dismissProgressView(view: self.view)
            
        }
    }
    
    func WarningDetailsData() {
        
        warningType.text = MyWarningDetailsById[0]["IsWarningType"].stringValue
        warningNameLbl.text = MyWarningDetailsById[0]["WarningName"].stringValue
        createDate = MyWarningDetailsById[0]["CreatedDate"].stringValue
        // miliseconds to date
        let millis=createDate
        print(millis,"millis")
        let Doublemillis = Double(createDate)
        
        let Createdate = Date(timeIntervalSince1970: (Doublemillis! / 1000.0))
        let formatters = DateFormatter()
        formatters.dateFormat = "dd/MM/yyyy"
        print("Createddate",formatters.string(from: Createdate as Date))
        createDateLbl.text = "\(formatters.string(from: Createdate as Date ))"
        
        
        militoDate = MyWarningDetailsById[0]["ExpirationDate"].stringValue
        
        // miliseconds to date 
        let milliseconds=militoDate
        print(milliseconds,"milliseconds")
        let Doublemilliseconds = Double(militoDate)
        
        let Expirydate = Date(timeIntervalSince1970: (Doublemilliseconds! / 1000.0))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        print("ModifyExpirydate",formatter.string(from: Expirydate as Date))
        expirationDateLbl.text = "\(formatter.string(from: Expirydate as Date ))"
        
//        expirationDateLbl.text = MyWarningDetailsById[0]["ExpirationDate"].stringValue
        warningDetailLbl.text = MyWarningDetailsById[0]["WarningDetails"].stringValue
        instanceLbl.text = MyWarningDetailsById[0]["Instance"].stringValue
        
        if warningType.text?.count == 0 {
            labelHeightConstraint.constant = 0
        } else {
            labelHeightConstraint.constant = 30
        }
    }
    
    
    @IBAction func backBtnModify(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentAccountViewController") as! MyCurrentAccountViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func modifyAction(_ sender: UIButton) {
        isClickModify = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWarningViewController") as! CreateNewWarningViewController
        vc.addWarningData = self.MyWarningDetailsById
        self.navigationController?.pushViewController(vc, animated: true)
        
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ModifyPopupVC") as! ModifyPopupVC
//
//        vc.WarningDetailsById = self.MyWarningDetailsById
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: false, completion: nil)
    }
    
    
    
    @IBAction func dropAction(_ sender: UIButton) {
        
        AddWarning()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DroppedPopupVC") as! DroppedPopupVC
        vc.labelName = MyWarningDetailsById[0]["WarningName"].stringValue
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    //Mark:- AddWarning Api
    func AddWarning() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().AddWarning(Id:DataManager.Id!, UserId: "\(DataManager.UserId!)", WarningName: "", ExpirationDate: "", Instance: "", AlertChannel: "", PaymentChannel: "", WarningDetails: "", BillingMethod: "", IsWarningType: "", IsDropWarning: true, CreatedDate: "", WarningTypeDateTime: "", currentVC: self ) {
            
            (response) in
            
            print("AddWarning response",response)
            
            let dataArray = response["dataArray"].arrayValue
            print("dataArray", dataArray)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrentAccountViewController") as! MyCurrentAccountViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            CommonFunctions.dismissProgressView(view: self.view)
        }
    }
}
