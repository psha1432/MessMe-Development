//
//  ApiController.swift
//  RewayatyApp
//
//  Created by Logictrix-3 on 01/07/21.
//

import UIKit
import Alamofire

class APIController: NSObject {
    
    var localParameter:[String:Any]!
    
    
    // Mark : - For Registration Api
    func Registration(Id:Int,Name:String,Email:String,PhoneNumber:String,Password:String,Dob:String,Gender:String, currentVC:UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
        let parameters: [String:Any] =
        ["Id":Id,"Name":Name,"Email":Email,"PhoneNumber":PhoneNumber,"Password": Password,"Dob" :Dob ,"Gender" : Gender]
        
        print("parameters",parameters)
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.Register, param: parameters, onSuccess: { (response) in
            
            print("Registration response ",response)
            
            CommonFunctions.dismissProgressView(view: currentVC.view)
            if(response["status"].stringValue == "1")
            {
                successHandler(response)
            }
            else
            {
                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
            }
            
        }) { (error) in
            CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.debugDescription)
            //  CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
        
    }
    
    
    
    // For Login
    func Login(PhoneNumber:String,Password:String,DeviceId:String,DeviceType:String, currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
        let parameters: [String:Any] =
        ["PhoneNumber":PhoneNumber,"Password":Password,"DeviceId":DeviceId,"DeviceType":DeviceType]
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.Login, param: parameters, onSuccess: { (response) in
            
            print("Login response ",response)
            
            if(response["status"].stringValue == "1")
            {
                successHandler(response)
            }
            else
            {
                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error".localiz())
                CommonFunctions.dismissProgressView(view: currentVC.view)
                
            }
            
        }) { (error) in
            // CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.debugDescription)
            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
    }
    
    
    // Mark : - For AddWarning Api
    func AddWarning(Id:Int,UserId:String,WarningName:String,ExpirationDate:String,Instance:String,AlertChannel:String,PaymentChannel:String,WarningDetails:String,BillingMethod:String,IsWarningType:String,IsDropWarning:Bool,CreatedDate:String,WarningTypeDateTime:String, currentVC:UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
        let parameters: [String:Any] =
        ["Id":Id,"UserId":UserId,"WarningName":WarningName,"ExpirationDate":ExpirationDate,"Instance": Instance,"AlertChannel" :AlertChannel ,"PaymentChannel" : PaymentChannel,"WarningDetails" : WarningDetails,"BillingMethod" : BillingMethod,"IsWarningType" : IsWarningType,"IsDropWarning" : "\(IsDropWarning)" ,"CreatedDate" : CreatedDate, "WarningTypeDateTime" :WarningTypeDateTime]
        
        print("parameters",parameters)
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.AddWarning, param: parameters, onSuccess: { (response) in
            
            print("AddWarning response ",response)
            
            CommonFunctions.dismissProgressView(view: currentVC.view)
            if(response["status"].stringValue == "1")
            {
                successHandler(response)
            }
            else
            {
                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
            }
            
        }) { (error) in
            CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.debugDescription)
            //  CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
        
    }
    
    
    // For GetMyWarningList Api
    func
    GetMyWarningList(UserId:Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
        let parameters: [String:Any] = ["UserId":UserId]
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.GetMyWarningList, param: parameters, onSuccess: { (response) in
            
            print("GetMyWarningList response ",response)
            
            if(response["status"].stringValue == "1")
            {
                successHandler(response)
            }
            else
            {
                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
                CommonFunctions.dismissProgressView(view: currentVC.view)
                
            }
            
        }) { (error) in
            // CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.debugDescription)
            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
        
    }
    
    // For GetMyWarningDetailsById Api
    func GetMyWarningDetailsById(
        WarningId:Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
            let parameters: [String:Any] = ["WarningId":WarningId]
            
            AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.GetMyWarningDetailsById, param: parameters, onSuccess: { (response) in
                
                print("GetMyWarningDetailsById response ",response)
                
                if(response["status"].stringValue == "1")
                {
                    successHandler(response)
                }
                else
                {
                    CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
                    CommonFunctions.dismissProgressView(view: currentVC.view)
                    
                }
                
            }) { (error) in
                // CommonFunctions.dismissProgressView(view: currentVC.view)
                print(error.debugDescription)
                //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
            }
            
        }
    
    // For ForgotPassword Api
    func ForgotPassword(Email:String, currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
        let parameters: [String:Any] = ["Email":Email]
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.ForgotPassword, param: parameters, onSuccess: { (response) in
            
            print("ForgotPasswordResponse ",response)
            
            CommonFunctions.dismissProgressView(view: currentVC.view)
            if(response["status"].stringValue == "1")
            {
                successHandler(response)
            }
            else
            {
                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
            }
            
        }) { (error) in
//            CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.debugDescription)
//            CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
        
    }
    
  
//  paypalParam (Amount, PaymentMethodNonce, DeviceData, OrderId, WarningId)
    // For PaypalPayment Api
    func PaypalPayment(Amount:Double,PaymentMethodNonce:String,DeviceData:String,OrderId:String,WarningId:String, currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
        let parameters: [String:Any] = ["Amount":Amount,"PaymentMethodNonce":PaymentMethodNonce,"DeviceData":DeviceData,"OrderId":OrderId,"WarningId":WarningId]
        
        print("parameters",parameters)
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.PaypalPayment, param: parameters, onSuccess: { (response) in
            
            print("PaypalPayment Response ",response)
            
            CommonFunctions.dismissProgressView(view: currentVC.view)
            if(response["status"].stringValue == "1")
            {
                successHandler(response)
            }
            
            else
            {
                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
            }
            
        }) { (error) in
//            CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.debugDescription)
//            CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
        
    }
    
}
    
    //    //    // Mark : - For Registration Api
    //    func AddBusiness(Id:Int,UserId:Int ,BusinessName:String,BusinessCategory:String,Phone:String,BusinessAddress:String,BusinessLocation:String,BusinessPhotos: [[String:Any]],BusinessDays:[[String:Any]],ServiceData:[[String:Any]],latitude:String,Area:String,longitude:String,DeletedFile:[[String:Any]],currentVC:UIViewController, FacebookUrl:String, YoutubeUrl:String, InstaUrl:String, TwitterUrl:String,   successHandler: @escaping (_ success:JSON) -> Void) {
    //
    //
    //        print("BusinessDays ",BusinessDays)
    //
    //        //        [{toTime:"3:48 PM", fromTime:"1:48 PM", dayName:"monday"}, {toTime:"07:00 PM", dayName:"tuesday", fromTime:"07:00 AM"}, {toTime:"07:00 PM", dayName:"wednesday", fromTime:"07:00 AM"}, {toTime:"07:00 PM", fromTime:"07:00 AM", dayName:"wednesday"}, {dayName:"wednesday", fromTime:"07:00 AM", toTime:"07:00 PM"}, {dayName:"wednesday", fromTime:"07:00 AM", toTime:"07:00 PM"}, {fromTime:"07:00 AM", toTime:"07:00 PM", dayName:"wednesday}]
    //        //
    //        //            var buisnessDayStr = "\(BusinessDays)"
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "\"", with: "")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "[[", with: "[{")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ": ", with: ":\"")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ",", with: "\",")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "]\"", with: "\"}")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "[\"", with: "\"}")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "]]", with: "}]")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ", [", with: ", {")
    //        //                buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ", [", with: ", {")
    //        //            print("buisnessDayStr ",buisnessDayStr)
    //
    //
    //        var businessrefinedArray = String()
    //        for bd in 0..<BusinessDays.count {
    //            let buisnessDictData = BusinessDays[bd]
    //            print("buisnessDictData \(bd)",buisnessDictData)
    //            var buisnessDayStr:String = "\(buisnessDictData)"
    //
    //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "\"", with: "")
    //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "[", with: "{")
    //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "]", with: "}")
    //
    //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ": ", with: ":\"")
    //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ", ", with: "\", ")
    //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "}", with: "\"}")
    //
    //            print("buisnessDayStr ",buisnessDayStr)
    //
    //            businessrefinedArray = buisnessDayStr + "," + businessrefinedArray
    //        }
    //        print("businessrefinedArray ",businessrefinedArray)
    //
    //        //        var buisnessDayStr = "\(BusinessDays)"
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "\"", with: "")
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "[[", with: "[{")
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ": ", with: ":\"")
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ",", with: "\",")
    //        //
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "]\"", with: "\"}")
    //        //
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "[\"", with: "\"}")
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: "]]", with: "}]")
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ", [", with: ", {")
    //        //            buisnessDayStr = buisnessDayStr.replacingOccurrences(of: ", [", with: ", {")
    //        //        print("buisnessDayStr ",buisnessDayStr)
    //
    //
    //
    //        var BusinessPhotosStr = "\(BusinessPhotos)"
    //        BusinessPhotosStr = BusinessPhotosStr.replacingOccurrences(of: "[\"", with: "{")
    //        BusinessPhotosStr = BusinessPhotosStr.replacingOccurrences(of: "\":", with: ":")
    //        BusinessPhotosStr = BusinessPhotosStr.replacingOccurrences(of: "\"]", with: "\"}")
    //        print("BusinessPhotosStr ",BusinessPhotosStr)
    //
    //        var DeletedFileStr = "\(DeletedFile)"
    //        DeletedFileStr = DeletedFileStr.replacingOccurrences(of: "[\"", with: "{")
    //        DeletedFileStr = DeletedFileStr.replacingOccurrences(of: "\":", with: ":")
    //        DeletedFileStr = DeletedFileStr.replacingOccurrences(of: "\"]", with: "\"}")
    //        print("DeletedFileStr ",DeletedFileStr)
    //
    //
    //        var refinedServiceData = String()
    //        for i in 0..<ServiceData.count {
    //            let ServiceDictData = ServiceData[i]
    //            print("ServiceDictData \(i)",ServiceDictData)
    //            var ServiceDataStr:String = "\(ServiceDictData)"
    //
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "[", with: "{")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "]", with: "}")
    //
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "\"ServiceName\"", with: "ServiceName")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "\"ServiceDescription\"", with: "ServiceDescription")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "\"ServiceImage\"", with: "ServiceImage")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "\"ServiceVideo\"", with: "ServiceVideo")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "\"ServiceId\"", with: "ServiceId")
    //
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "{\"", with: "[\"")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "mp4\"}", with: "mp4\"]")
    //            ServiceDataStr = ServiceDataStr.replacingOccurrences(of: "png\"}", with: "png\"]")
    //
    //            print("ServiceDataStr \(i)",ServiceDataStr)
    //
    //            //            refinedServiceData.append(ServiceDataStr)
    //            refinedServiceData = ServiceDataStr + "," + refinedServiceData
    //        }
    //
    //        print("refinedServiceData ",refinedServiceData)
    //
    //        let parameters: [String:Any] = ["BusinessLocation": BusinessLocation,
    //                                        "longitude": longitude,
    //                                        "TwitterUrl": TwitterUrl,
    //                                        "UserId": UserId,
    //                                        "Id": Id,
    //                                        "FacebookUrl": FacebookUrl,
    //                                        "BusinessName": BusinessName,
    //                                        "Phone": Phone,
    //                                        "Area": Area,
    //                                        "InstaUrl": InstaUrl,
    //                                        "BusinessCategory": BusinessCategory,
    //                                        "BusinessAddress": BusinessAddress,
    //                                        "YoutubeUrl": YoutubeUrl,
    //                                        "latitude": latitude,
    //                                        "BusinessDays": "[\(businessrefinedArray)]",
    //                                        "BusinessPhotos": BusinessPhotosStr,
    //                                        "ServiceData": "[\(refinedServiceData)]",
    //                                        "DeletedFile": DeletedFileStr]
    //
    //
    //        //        ["FacebookUrl": "",
    //        //
    //        //         "BusinessAddress": "jaipur",
    //        //
    //        //         "ServiceData": ["{ServiceImage: ["d0d4dd9d-83a4-45e8-837b-f152dbbd9e73.png", "1a695ecb-2349-4f3d-822b-01c207bebeb7.png"], ServiceName: "name", ServiceVideo: ["e136db30-be92-46c2-9cf5-fbbd4fa0a42c.mp4", "25e6dd37-dcf0-4f59-b9fe-222e838692c5.mp4"], ServiceDescription: "desc", ServiceId: 0}", "{ServiceDescription: "serviceDescription", ServiceVideo: ["38cea3ef-0e3d-4472-b2ed-4004874b2f31.mp4", "40f69962-6ad7-4358-9f1c-8c64908113d1.mp4"], ServiceName: "serviceNames", ServiceImage: ["c0870159-29dc-49cd-984c-f860d3062ba7.png", "804efb67-eb04-4e12-b660-1a7e22d66cc2.png"], ServiceId: 0}"],
    //        //
    //        //         "latitude": "26.854293823242188",
    //        //
    //        //         "TwitterUrl": "",
    //        //
    //        //         "BusinessName": "Test Ios",
    //        //
    //        //         "BusinessCategory": "Laundry service",
    //        //
    //        //         "BusinessDays": "[{toTime:"3:48 PM", fromTime:"1:48 PM", dayName:"monday"}, {toTime:"07:00 PM", dayName:"tuesday", fromTime:"07:00 AM"}, {toTime:"07:00 PM", dayName:"wednesday", fromTime:"07:00 AM"}, {toTime:"07:00 PM", fromTime:"07:00 AM", dayName:"wednesday"}, {dayName:"wednesday", fromTime:"07:00 AM", toTime:"07:00 PM"}, {dayName:"wednesday", fromTime:"07:00 AM", toTime:"07:00 PM"}, {fromTime:"07:00 AM", toTime:"07:00 PM", dayName:"wednesday}]",
    //        //
    //        //         "UserId": "1774",
    //        //
    //        //         "Area": "Marcory",
    //        //
    //        //         "BusinessLocation": "Triveni Marg,Jaipur,RJ ,India,302020",
    //        //
    //        //         "YoutubeUrl": "",
    //        //
    //        //         "BusinessPhotos": "[{FileName: "a5c86b4c-a027-4bcc-a700-7f3a85e6eaca.png"}, {FileName: "b868976b-e37a-4b1a-b862-43f48e3053c9.png"}]",
    //        //
    //        //         "Phone": "12345678990",
    //        //
    //        //         "longitude": "75.76706374509453",
    //        //
    //        //         "Id": "0",
    //        //
    //        //         "DeletedFile": "[{DelFile: ""}]",
    //        //
    //        //         "InstaUrl": ""]
    //
    //        print("parameters ",parameters)
    //
    ////        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.AddBusiness, param: parameters, onSuccess: { (response) in
    //            print("AddBusiness response ",response)
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //                // CommonFunctions.showAlert(currentVC, message: "message", title: "Error")
    //            }
    //            else
    //            {
    //
    //                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
    //            }
    //
    //        }) { (error) in
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //  CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For FavBusinessById Api
    //    func FavBusinessById(BusinessId:Int,UserId:Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["BusinessId":BusinessId,"UserId" : UserId]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.FavBusinessById, param: parameters, onSuccess: { (response) in
    //            print("parameters ",parameters)
    //            CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For GetBusiness Api
    //    func GetBusiness(userid : Int,AppUserId:Int,CategoryEnglish:String,CategoryFrench:String,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["userid" : userid,"AppUserId":AppUserId,"CategoryEnglish" : CategoryEnglish,"CategoryFrench":CategoryFrench]
    //        print("parameters ",parameters)
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetBusiness, param: parameters, onSuccess: { (response) in
    //            print("GetBusiness response ",parameters)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //           CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    //    // Mark : - For UploadFiles Api
    //    func UploadFiles(currentVC:UIViewController ,successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        [:]
    //
    ////        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.UploadFiles, param: parameters, onSuccess: { (response) in
    //            print("UploadFiles response ",response)
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //                // CommonFunctions.showAlert(currentVC, message: "message", title: "Error")
    //            }
    //            else
    //            {
    //
    //                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
    //            }
    //
    //        }) { (error) in
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //  CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    //    // Mark : - For BusinessReview Api
    //    func BusinessReview(UserId:Int,BusinessId:Int,Rating:Int,BusinessReview:String,CreatedDate:Int,currentVC:UIViewController ,successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["UserId":UserId,"BusinessId":BusinessId,"Rating":Rating,"BusinessReview":BusinessReview,"CreatedDate":CreatedDate]
    //
    ////        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.BusinessReview, param: parameters, onSuccess: { (response) in
    //            print("BusinessReview response ",response)
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //                // CommonFunctions.showAlert(currentVC, message: "message", title: "Error")
    //            }
    //            else
    //            {
    //
    //                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
    //            }
    //
    //        }) { (error) in
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //  CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For GetAllReview Api
    //    func GetAllReview(BusinessId : Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["BusinessId" : BusinessId]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetAllReview, param: parameters, onSuccess: { (response) in
    //            print("GetAllReview response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For GetFavoriteBusiness Api
    //    func GetFavoriteBusiness(UserId : Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["UserId" : UserId]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetFavoriteBusiness, param: parameters, onSuccess: { (response) in
    //            print("GetFavoriteBusiness response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    //    // Mark : - For BusinessReview Api
    //    func SaveFavoriteBusiness(UserId:Int,BusinessId:Int,currentVC:UIViewController ,successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["UserId":UserId,"BusinessId":BusinessId]
    //
    ////        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.SaveFavoriteBusiness, param: parameters, onSuccess: { (response) in
    //            print("SaveFavoriteBusiness response ",response)
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //                // CommonFunctions.showAlert(currentVC, message: "message", title: "Error")
    //            }
    //            else
    //            {
    //
    //                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
    //            }
    //
    //        }) { (error) in
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //  CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For BusinessAllData Api
    //    func BusinessAllData(BusinessId : Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["BusinessId" : BusinessId]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.BusinessAllData, param: parameters, onSuccess: { (response) in
    //            print("BusinessAllData response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For SearchBusiness Api
    //    func SearchBusiness(SearchData:String,UserId : Int,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["SearchData" : SearchData,"UserId":UserId]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.SearchBusiness, param: parameters, onSuccess: { (response) in
    //            print("SearchBusiness response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    //    // Mark : - For BusinessSubscription Api
    //    func BusinessSubscription(BusinessId:Int,UserId:Int,PackType:String,Days:Int,Date:String,IsAds:Bool,currentVC:UIViewController,successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["BusinessId":BusinessId,"UserId":UserId,"PackType":PackType,"Days":Days,"Date":Date,"IsAds":"\(IsAds)"]
    //        print("parameters",parameters)
    //
    ////        AlamoFireWrapper.sharedInstance.PostApiHit(action: AppConstant.AppURL.BusinessSubscription, param: parameters, onSuccess: { (response) in
    //            print("BusinessSubscription response ",response)
    //            //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //
    //
    //                // CommonFunctions.showAlert(currentVC, message: "message", title: "Error")
    //            }
    //            else
    //            {
    //
    //                CommonFunctions.showAlert(currentVC, message: response["message"].stringValue, title: "Error")
    //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //            }
    //
    //        }) { (error) in
    //            CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For GetSubscriptionLimit Api
    //    func GetSubscriptionLimit(currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        [:]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetSubscriptionLimit, param: parameters, onSuccess: { (response) in
    //            print("GetSubscriptionLimit response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //
    //    // For GetPremiumBusiness Api
    //    func GetPremiumBusiness(CurrrentDate:Double,UserID:Int,IsAds:Bool,currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        ["CurrrentDate":CurrrentDate,"UserID":UserID,"IsAds":"\(IsAds)"]
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetPremiumBusiness, param: parameters, onSuccess: { (response) in
    //            print("parameters",parameters)
    //            print("GetPremiumBusiness response ",response)
    //            CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //           CommonFunctions.showAlert(currentVC, message: error., title: "Error!")
    //        }
    //
    //    }
    //
    //    // For GetCategory Api
    //    func GetCategory(currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        [:]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetCategory, param: parameters, onSuccess: { (response) in
    //            print("GetCategory response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            DispatchQueue.main.async {
    //                CommonFunctions.dismissProgressView(view: currentVC.view)
    //                CommonFunctions.showAlert(currentVC, message: "The request timed out", title: appName)
    //            }
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
    //    // For GetArea Api
    //    func GetArea(currentVC: UIViewController, successHandler: @escaping (_ success:JSON) -> Void) {
    //        let parameters: [String:Any] =
    //        [:]
    //
    ////        AlamoFireWrapper.sharedInstance.GetApiHit(action: AppConstant.AppURL.GetArea, param: parameters, onSuccess: { (response) in
    //            print("GetArea response ",response)
    //            //CommonFunctions.dismissProgressView(view: currentVC.view)
    //            if(response["status"].stringValue == "1")
    //            {
    //                successHandler(response)
    //            }
    //            else
    //            {
    //
    //
    //            }
    //
    //        }) { (error) in
    //            // CommonFunctions.dismissProgressView(view: currentVC.view)
    //            print(error.debugDescription)
    //            //CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
    //        }
    //
    //    }
    //
//}
