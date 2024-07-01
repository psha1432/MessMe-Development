//
//  PayPopupVC.swift
//  MessMe
//
//  Created by Prashant Sharma on 22/06/22.
//https://developer.paypal.com/braintree/docs/guides/paypal/testing-go-live#linked-paypal-testing


import UIKit
import BraintreeDropIn
import Braintree

class PayPopupVC: UIViewController {
    
    
    @IBOutlet weak var closeBtnPopupVw: UIViewCustomClass!
    @IBOutlet weak var payView: UIViewCustomClass!
    @IBOutlet weak var payBackView: UIView!
    @IBOutlet weak var amountTf: UITextField!
    
    var randomOrderId = String()
    
    var paymentNounce = String()
    var amount = Double()
    var braintreeClient: BTAPIClient?
    
    var previousNumber: UInt32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        braintreeClient = BTAPIClient(authorization: "sandbox_hcq47ptt_qpd7nrmr9vph7g86")
        
        let randomInt = Int.random(in: 11..<99)
        randomOrderId = String(randomInt)
        print("randomOrderId",randomOrderId)
        
    }
    
    
    @IBAction func payCloseBtn(_ sender: UIButton) {
        
        payBackView.isHidden = true
        payView.isHidden = true
        closeBtnPopupVw.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func payBtnActtion(_ sender: UIButton) {
        
        amount = Double(amountTf.text!)!
        print("amount",amount)
        
        if (amountTf.text!.count == 0) {
            CommonFunctions.showAlert(self, message: "Please Enter Amount".localiz(), title: appName)
        } else {
            CommonFunctions.startProgressView(view: self.payView)
            startCheckout()
//            showDropIn(clientTokenOrTokenizationKey: "sandbox_hcq47ptt_qpd7nrmr9vph7g86")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [self] in
            payView.isHidden = true
            payBackView.isHidden = true
            closeBtnPopupVw.isHidden = true
            self.dismiss(animated: true, completion: nil)
            CommonFunctions.dismissProgressView(view: self.payView)
            }
        }
    }
    
//    self.dataCollector.collectDeviceData() { deviceData in
//        // Send deviceData to your server
//    }
    
    func startCheckout() {
        // Example: Initialize BTAPIClient, if you haven't already
        //        braintreeClient = BTAPIClient(authorization: "sandbox_hcq47ptt_qpd7nrmr9vph7g86")!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalCheckoutRequest(amount: amountTf.text!)
        request.currencyCode = "USD" // Optional; see BTPayPalCheckoutRequest.h for more options
        
        payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                self.paymentNounce = tokenizedPayPalAccount.nonce
            
                // Access additional information
                let email = tokenizedPayPalAccount.email
                debugPrint(email!)
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
                
                print("email ",email!)
                print("firstName ",firstName!)
                print("lastName ",lastName!)
//                print("phone ",phone!)
//                print("billingAddress ",billingAddress!)
//                print("shippingAddress ",shippingAddress!)
                self.paypalPayment()
            }
            else if let error = error {
                // Handle error here...
                print("paypalerror ",error)
            } else {
                // Buyer canceled payment approval
            }
        }
        
    }
    
    
//    func showDropIn(clientTokenOrTokenizationKey: String) {
//        let request =  BTDropInRequest()
//        let dropIn = BTDropInController(authorization: "sandbox_hcq47ptt_qpd7nrmr9vph7g86", request: request)
//        { (controller, result, error) in
//            if (error != nil) {
//                print("ERROR")
//            } else if (result?.isCanceled == true) {
//                print("CANCELED")
//            } else if let result = result {
//                // Use the BTDropInResult properties to update your UI
//                result.paymentMethodType
//                print("paymentMethod",result.paymentMethodType)
//                result.paymentMethod
//                result.paymentIcon
//                result.paymentDescription
//            }
//            controller.dismiss(animated: true, completion: nil)
//        }
//        self.present(dropIn!, animated: true, completion: nil)
//    }
    
    
    func paypalPayment() {
        CommonFunctions.startProgressView(view: self.view)
        
        APIController().PaypalPayment(Amount: amount, PaymentMethodNonce: paymentNounce, DeviceData: "", OrderId: randomOrderId, WarningId: "", currentVC: self) { (response) in
            
            
            CommonFunctions.dismissProgressView(view: self.view)
        }
    }
}
