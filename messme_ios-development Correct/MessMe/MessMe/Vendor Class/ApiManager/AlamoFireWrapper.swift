//
//  AlamoFireWrapper.swift
//  BlackIchDatingAppFranziska
//
//  Created by ShiviMac on 12/04/21.
//

import UIKit
import Alamofire
import AssetsLibrary
import Photos
import MBProgressHUD

class AlamoFireWrapper: NSObject {

    let customManager = Alamofire.Session.default
    let timeOutInterval:Double = 60
    
    var progressViewNib = UIView()
    
    class var sharedInstance : AlamoFireWrapper{
        struct Singleton{
            static let instance = AlamoFireWrapper()
        }
        return Singleton.instance;
    }
    
    
    
    //MARK: MULTIPART API
        func MultipartApiHit(action:String,imageData: Data?,view: UIView,param: [String:Any], withName: String, fileName: String, mimeType: String, onSuccess: @escaping(AFDataResponse<Any>) -> Void, onFailure: @escaping(Error) -> Void){
            
            let url : String = AppConstant.AppURL.BaseURL + action
            print("url",url)
            print("param ",param)
            let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data",
                "Accept": "application/json"
            ]
            
            AF.upload(
                multipartFormData: { multipartFormData in
                    for (key, value) in param {
                        if let temp = value as? String {
                            multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                        }
                        if let temp = value as? Int {
                            multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                        }
                        if let temp = value as? NSArray {
                            temp.forEach({ element in
                                let keyObj = key + "[]"
                                if let string = element as? String {
                                    multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                                } else
                                if let num = element as? Int {
                                    let value = "\(num)"
                                    multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                                }
                            })
                        }
                    }
                    multipartFormData.append(imageData!, withName: withName , fileName: fileName, mimeType: mimeType)
                    //, fileName: "file.jpeg", mimeType: "image/jpeg"
                    //               progressBar.progress = Float(50.0)
                },
                to: url, method: .post , headers: headers)
                .responseJSON {
                    (response:AFDataResponse<Any>) in
                    print("response ",response)
                    switch(response.result) {
                    case .success( _):
                        //                    progressBar.progress = Float(100.0)
                        DispatchQueue.main.async {
                           // self.hideProgressView()
                        }
                        onSuccess(response)
                        break
                    case .failure(let error):
                        print("error==> ",error)
                        onFailure(error)
                        DispatchQueue.main.async {
                           // self.hideProgressView()
                        }
                        break
                    }
                }
        }
    
    //MARK:- Post Request
    func PostApiHit(action:String,param: [String:Any], onSuccess: @escaping(_ success:JSON) -> Void, onFailure: @escaping(_ success:JSON) -> Void){
        let url : String = AppConstant.AppURL.BaseURL + action
        print("url ",url)
        //        print("param ",param)
        let errorDict:[String:Any] = [:]
        let errorJson:JSON = JSON(errorDict)
        var jsonResponse:JSON!
        
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response:AFDataResponse<Any>) in
           print("response ",response)
            switch(response.result) {
            case .success(_):
                
                let json = JSON(data: response.data!)
//                    print("\(json)")
                jsonResponse = json
                onSuccess(jsonResponse)
                
                break
            case .failure(let error):
                print("error==> ",error)
                DispatchQueue.main.async {
                  //  CommonFunctions.dismissProgressView(view: view)
                }
                onFailure(errorJson)
                break
            }
        }
    }
    
    //MARK:- Post Request
    func TripPostApiHit(action:String,param: [String:Any], onSuccess: @escaping(_ success:JSON) -> Void, onFailure: @escaping(_ success:JSON) -> Void){
        let url : String = AppConstant.AppURL.BaseURL + action
        print("url ",url)
             print("param ",param)
        let errorDict:[String:Any] = [:]
        let errorJson:JSON = JSON(errorDict)
        var jsonResponse:JSON!
        
//
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let data = try! JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//        if let json = json {
//            print(json)
//        }
//        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
//
//        AF.request(request).responseJSON { (response) in
//
//
//            print(response)
//
//        }
        
//                    AF.request(request as! URLRequestConvertible)
//                        .responseJSON { response in
//                            // do whatever you want here
//                           print(response.request)
//                           print(response.response)
//                           print(response.data)
//                           print(response.result)
//
//                    }
        
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON {
            (response:AFDataResponse<Any>) in
           print("response ",response)
            switch(response.result) {
            case .success(_):

                let json = JSON(data: response.data!)
                    print("\(json)")
                jsonResponse = json
                onSuccess(jsonResponse)

                break
            case .failure(let error):
                print("error==> ",error)
                DispatchQueue.main.async {
                // CommonFunctions.dismissProgressView(view: view)
                }
                onFailure(errorJson)
                break
            }
        }
    }
    


    //MARK:- Normal Get Request
    func GetApiHit(action:String,param: [String:Any],onSuccess: @escaping(_ success:JSON) -> Void, onFailure: @escaping(_ success:JSON) -> Void){
        let url : String = AppConstant.AppURL.BaseURL + action
        
        print("param ", param)
        print("action url", url)
        
        let errorDict:[String:Any] = [:]
        let errorJson:JSON = JSON(errorDict)
        var jsonResponse:JSON!
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 90
        
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {
                    (response:AFDataResponse<Any>) in
                    print("response ",response)
                    switch(response.result) {
                    case .success(_):
                        
                        let json = JSON(data: response.data!)
                          //  print("\(json)")
                        jsonResponse = json
                        onSuccess(jsonResponse)
                        
                        break
                    case .failure(let error):
                        print("error==> ",error)
                        onFailure(errorJson)
                        break
                    }
                }
        
//        AF.request(AppConstant.AppURL.BaseURL+action, method: .get, parameters: param,  headers: nil).responseJSON {
//            (response:AFDataResponse<Any>) in
//            print("API Url", AppConstant.AppURL.BaseURL+action)
//            //                print("response", response)
//
//            switch(response.result) {
//
//            case .success(_):
//
//                let json = JSON(data: response.data!)
//                  //  print("\(json)")
//                jsonResponse = json
//                onSuccess(jsonResponse)
//
//                break
//            case .failure(let error):
//                print("error==> ",error)
//
//                onFailure(errorJson)
//                break
//
//            }
//
//        }
    }
    
    
    
    func requestGETURL(action: String, param: [String:Any], view: UIView, onSuccess:@escaping(_ success:JSON) -> Void, onFailure:@escaping(_ success:JSON) -> Void){
        
        let strURL : String = AppConstant.AppURL.BaseURL+action
        print("strURL ",strURL)
        let errorDict:[String:Any] = [:]
        let errorJson:JSON = JSON(errorDict)
        var jsonResponse:JSON!
        
        let urlwithPercentEscapes = strURL.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
//        var headers = HTTPHeaders()
        //            var headers = [String: String]()
//        headers = ["token": DataManager.registrationToken!,
//                   "content-type": "application/json"]
        
//        print("headers ",headers)
        
        print("urlwithPercentEscapes ",urlwithPercentEscapes!)
        
        //        Alamofire.request(urlwithPercentEscapes!, method: .get, parameters: nil, encoding: JSONEncoding.default,headers: headers)
        AF.request(urlwithPercentEscapes!, method: .get, parameters: param, encoding: JSONEncoding.default,headers: nil)
            .responseJSON { (response:AFDataResponse<Any>) in
                print("strUrl ", strURL)
                print("response ", response)
                switch(response.result) {
                case .success(_):
                    
                    let json = JSON(data: response.data!)
    //                    print("\(json)")
                    jsonResponse = json
                    onSuccess(jsonResponse)
                    
                    break
                case .failure(let error):
                    print("error==> ",error)
                    DispatchQueue.main.async {
                      //  CommonFunctions.dismissProgressView(view: view)
                    }
                    onFailure(errorJson)
                    break
                }
            }
    }
    
    
    //MARK: MULTIPART API
         func multipleImageUploadApiHit(action:String,imagesData: [Data?],fetchImageParamNameArray: [String],view: UIView,param: [String:Any], extensionType: String, onSuccess: @escaping(AFDataResponse<Any>) -> Void, onFailure: @escaping(Error) -> Void){

             let url : String = AppConstant.AppURL.BaseURL + action
             print("url",url)
             print("param ",param)
             print("withName: \(extensionType)")
             let headers: HTTPHeaders = [
                 "Content-type": "multipart/form-data",
                 "Accept": "application/json"
             ]
             
             var imageParamNameArray = fetchImageParamNameArray
             
             AF.upload(
                 multipartFormData: { multipartFormData in
                     
                     for imageData in imagesData {
                         let imageParamName = imageParamNameArray[0]
                         imageParamNameArray.remove(at: 0)
                         multipartFormData.append(imageData!, withName: "\(imageParamName)", fileName: "\(imageParamName).\(extensionType)", mimeType: "\(imageParamName)/\(extensionType)")
                     }
                     //Date().timeIntervalSince1970
                    
                     for (key, value) in param {
                         
                        if let temp = value as? String {
                            multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                        }
                         
                        if let temp = value as? Int {
                            multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                        }
                         
                        if let temp = value as? NSArray {
                            temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                                }
                            })
                        }
                                              
                }
                     
             },
                 to: url, method: .post , headers: headers)
                 .responseJSON {
                     (response:AFDataResponse<Any>) in
                     print("response ",response)
                     switch(response.result) {
                     case .success( _):
                         DispatchQueue.main.async {
    //                         self.hideProgressView()
                         }
                         onSuccess(response)
                         break
                     case .failure(let error):
                         print("error==> ",error)
                         onFailure(error)
                         DispatchQueue.main.async {
    //                         self.hideProgressView()
                         }
                         break
                     }
             }
         }
    
    //Mark- to fix orientation in Image upload
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    //Mark- to Show progress Bar
//    func showProgressView(){
//        let nibContents = Bundle.main.loadNibNamed("progressView", owner: nil, options: nil)
//        progressViewNib = nibContents![0] as! UIView
//        let progressBar = (progressViewNib.viewWithTag(1)! as! UIProgressView)
//        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
//        applicationDelegate.window?.rootViewController?.view.addSubview(progressViewNib)
//        progressViewNib.center = (applicationDelegate.window?.rootViewController?.view.center)!
//        progressViewNib.frame.origin.y = (applicationDelegate.window?.rootViewController?.view.frame.size.height)!-300
//        //        UIApplication.shared.beginIgnoringInteractionEvents()
//        applicationDelegate.window?.isUserInteractionEnabled = false
//    }
    
//    func hideProgressView(){
//        progressViewNib.removeFromSuperview()
//        //        UIApplication.shared.endIgnoringInteractionEvents()
//        applicationDelegate.window?.isUserInteractionEnabled = true
//    }
    
    //Mark- create thumbnail
    func getThumbnailFrom(path: URL) -> UIImage? {
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTime.zero, actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
    }
    
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

