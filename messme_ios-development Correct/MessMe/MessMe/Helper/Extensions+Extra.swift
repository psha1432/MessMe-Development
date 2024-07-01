//
//  UINavigationController+Extra.swift
//  Thyssenkrupp
//
//  Created by Varun Naharia on 06/03/17.
//  Copyright © 2017 Varun Naharia. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD
import CoreData

extension UICollectionView {
   
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
        
        }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}

extension UINavigationController
{
    
    @discardableResult func popOrPushToViewController(viewController:UIViewController, animated:Bool) -> UIViewController? {
        var arrViewControllers:[UIViewController] = []
        
        arrViewControllers = self.viewControllers
        var isFound:Bool = false
        var vcs:[UIViewController]?
        for vc:UIViewController in arrViewControllers {
            if(vc.isKind(of: viewController.classForCoder))
            {
                vcs = self.popToViewController(vc, animated: animated)
                isFound = true
            }
        }
        if(isFound)
        {
            if(vcs != nil)
            {
                return vcs?.last
            }
        }
        else
        {
            self.pushViewController(viewController, animated: animated)
        }
        return  nil
    }
    
    
    func removeAnyViewControllers(ofKind kind: AnyClass)
    {
        self.viewControllers = self.viewControllers.filter { !$0.isKind(of: kind)}
    }
    
    /// Given the kind of a (UIViewController subclass),
    /// returns true if self's viewControllers array contains at
    /// least one matching instance.
    
    func containsViewController(ofKind kind: AnyClass) -> Bool
    {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
    
    func getViewController(ofKind kind: AnyClass) -> UIViewController?
    {
        return self.viewControllers.filter { $0.isKind(of: kind)}[0]
    }
    
}

extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}

extension UITableViewController {
    func showHudForTable(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
        hud.layer.zPosition = 2
        self.tableView.layer.zPosition = 1
    }
}

extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64(self.timeIntervalSince1970 * 1000.0)
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func string(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func daysBetween(date: Date) -> Double {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Double {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.second], from: date1, to: date2)
        return Double(a.value(for: .second)!)
    }
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
}

extension Dictionary
{
    func jsonString() -> String {
        
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        var JSONString:String!
        //Convert back to string. Usually only do this for debugging
        if let strJson = String(data: jsonData, encoding: String.Encoding.utf8) {
            print(strJson)
            JSONString = strJson
        }
        return JSONString
    }
    
    func jsonData() -> Data {
        
        let jsonDataObj = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        return jsonDataObj
    }
}

extension Array {
    mutating func delete(element: Int) {
        self = self.filter() { $0 as! Int != element }
    }
    
    mutating func delete(element: UIImage) {
        self = self.filter() { $0 as! UIImage != element }
    }
    
    mutating func delete(element: [String:Any]) {
        
    }
    
    func jsonString() -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        var JSONString:String!
        //Convert back to string. Usually only do this for debugging
        if let strJson = String(data: jsonData, encoding: String.Encoding.utf8) {
            print(strJson)
            JSONString = strJson
        }
        //        do {
        //            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [AnyObject].
        //            //var json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        
        return JSONString
    }
}
private var dataAssociationKey: UInt8 = 0
extension DispatchGroup {
    
    var data: [String:Any]! {
        get {
            return objc_getAssociatedObject(self, &dataAssociationKey) as? [String:Any]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &dataAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIToolbar {
    
    func ToolbarPiker(selector : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: selector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    func addDoneButton(_ closure: @escaping ()->()) -> UIToolbar  {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let sleeve = ClosureSleeve(closure)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: sleeve, action: #selector(ClosureSleeve.invoke))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        objc_setAssociatedObject(toolBar, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        return toolBar
    }
    
    
}

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func add(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func dataFromBase64() -> Data? {
        let dataDecoded : Data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)!
        return dataDecoded
    }
    
    var parseJSONString: Any? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let jsonData = data else { return nil }
        do { return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) }
        catch { return nil }
    }
    
    var stringToArray: [Any]? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let jsonData = data else { return nil }
        do { return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any] }
        catch { return nil }
    }
    
    func unEscape() -> String {
        var text = self.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
        text = text.replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
        text = text.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
        text = text.replacingOccurrences(of: "\t", with: "", options: NSString.CompareOptions.literal, range:nil)
        text = text.replacingOccurrences(of: "\n", with: "", options: NSString.CompareOptions.literal, range:nil)
        text = text.replacingOccurrences(of: "\r", with: "", options: NSString.CompareOptions.literal, range:nil)
        text = text.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        return text
    }
    
    func isValidURL() -> Bool {
        let urlString = self
        guard let url = URL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url) {return false}
        
        //
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self)
    }
    
}

extension NSData
{
    func toBase64() -> String {
        return  self.base64EncodedString(options: .lineLength64Characters)
    }
}

//https://stackoverflow.com/questions/21789770/determine-mime-type-from-nsdata
extension Data {
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
    ]
    
    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
}


extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}

extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = self.pngData()! as NSData
        let data2: NSData = image.pngData()! as NSData
        return data1.isEqual(data2)
    }
    
}

extension UIView {
    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
//        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func applyGradient1(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        //        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func applyGradientTopCornerToBottomCorner(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top left  to bottom right
            //            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        } else {
            //top right to bottom left
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
//        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyGradientTopCornerToBottomCorner1(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top left  to bottom right
            //            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        } else {
            //top right to bottom left
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
                gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Gradient
extension CAGradientLayer {
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

extension UIDevice {
    var iOS: Double? {
        if UIDevice.current.systemName == "iOS" {
            if let iosVersion = UIDevice.current.systemVersion.toDouble {
                return iosVersion
            }
        }
        return nil
    }
}

extension String {
    
    var toDouble: Double? {
        
        if let iosVersion = Double(self) {
            return iosVersion
        }
        
        let arr = components(separatedBy: ".")
        if arr.count >= 1 {
            var integerPart = 0
            var floatPart = 0
            
            if let _integerPart = Int(arr[0]), !arr[0].isEmpty{
                integerPart = _integerPart
            }
            
            if let _floatPart = Int(arr[1]), !arr[1].isEmpty{
                floatPart = _floatPart
            }
            
            return Double("\(integerPart).\(floatPart)")
        }
        return nil
    }
}

extension String {
        //Converts String to Int
        public func toInt() -> Int? {
            if let num = NumberFormatter().number(from: self) {
                return num.intValue
            } else {
                return nil
            }
        }
}

extension String {
    
    
    func trim() -> String {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    func trim(characterSet:CharacterSet) -> String {
        
        return self.trimmingCharacters(in: characterSet)
        
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad"
        case "iPad5,3", "iPad5,4":                      return "iPad"
        case "iPad6,11", "iPad6,12":                    return "iPad"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad"
        case "iPad5,1", "iPad5,2":                      return "iPad"
        case "iPad6,3", "iPad6,4":                      return "iPad"
        case "iPad6,7", "iPad6,8":                      return "iPad"
        case "iPad7,1", "iPad7,2":                      return "iPad"
        case "iPad7,3", "iPad7,4":                      return "iPad"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


extension UIColor {
    
    static let beige = UIColor(hexString: "F5F5DC")
    static let gold = UIColor(hexString: "d4af37")
    static let silver = UIColor(hexString: "aaa9ad")
    static let metallic = UIColor(hexString: "aaa9ad")
    static let appRedColor =  UIColor(red: 0.77, green: 0.06, blue: 0.00, alpha: 1.00)
    
    // Method returns a custom color
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return .init(red: blue / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
    
    static func getColorName(color:UIColor) -> String {
        switch color {
        case UIColor.beige:
            return "Beige"
        case UIColor.black:
            return "Black"
        case UIColor.blue:
            return "Blue"
        case UIColor.brown:
            return "Brown"
        case UIColor.gold:
            return "Gold"
        case UIColor.green:
            return "Green"
        case UIColor.gray:
            return "Gray"
        case UIColor.orange:
            return "Orange"
        case UIColor.purple:
            return "Purple"
        case UIColor.red:
            return "Red"
        case UIColor.silver:
            return "Silver"
        case UIColor.white:
            return "White"
        case UIColor.yellow:
            return "Yellow"
        case UIColor.metallic:
            return "Metallic"
        default:
            return "Unknown"
        }
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension NSManagedObject {
    func toJSON() -> String? {
        let keys = Array(self.entity.attributesByName.keys)
        var dict = self.dictionaryWithValues(forKeys: keys)
        dict = dict.mapValues({"\($0)"})
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            return reqJSONStr
        }
        catch{}
        return nil
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}


extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
    
    func loadGif(resourceName: String) {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        
        self.animationImages = images
    }
}
extension UIViewController {

func showToast(message : String, font: UIFont, yAxis: CGFloat) {
        let toastLabel = UILabel(frame: CGRect(x: 40, y: yAxis, width: self.view.frame.size.width-80, height: 60))
        toastLabel.backgroundColor =  UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.4, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}


