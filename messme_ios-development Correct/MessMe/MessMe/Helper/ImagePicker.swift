//
//  ImagePicker.swift
//  MarketPlace
//
//  Created by Logictrix-3 on 04/10/21.
//
var selectImage = Bool()
import Foundation
import UIKit
import AVKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?, url: NSURL?)
}

open class ImagePicker: NSObject {
    
    var videoURL: NSURL?
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        //        self.pickerController.sourceType = .photoLibrary
        //self.pickerController.mediaTypes = ["public.image","public.movie"]
        
        
        
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Camera roll") {
//            if pickingVideo == true {
//
//            }
//            else {
//                alertController.addAction(action)
//            }
        }
        
        if let action = self.action(for: .photoLibrary, title: "library") {
            alertController.addAction(action)
//            if pickingVideo == true {
//                self.pickerController.mediaTypes = ["public.movie"]
//            } else {
//                self.pickerController.mediaTypes = ["public.image"]
//            }
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, url: NSURL?) {
        if let imgPicked = image {
            selectImage = true
            controller.dismiss(animated: true, completion: nil)
            self.delegate?.didSelect(image: imgPicked, url: url)
            
            
        }
        
        else {
            controller.dismiss(animated: true, completion: nil)
            self.delegate?.didSelect(image: image, url: url)
            
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil, url: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        
        if let image = info[.editedImage] as? UIImage {
            self.pickerController(picker, didSelect: image, url: nil)
        }
        
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
            print(videoURL)
            do {
                let asset = AVURLAsset(url: videoURL as URL , options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                self.pickerController(picker, didSelect: thumbnail, url: videoURL)
                //  imgView.image = thumbnail
            }
            catch let error {
                print("*** Error generating thumbnail: \(error.localizedDescription)")
            }
        }
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}

