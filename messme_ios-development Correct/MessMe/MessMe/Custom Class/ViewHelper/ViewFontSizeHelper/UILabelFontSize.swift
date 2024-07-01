//
//  UILabelFontSize.swift
//  MessMe
//
//  Created by Logictrix on 13/05/22.
//

import Foundation
import UIKit

class UILabelFontSize: UILabel {
    override func awakeFromNib() {
        changeSize()
    }
    
    fileprivate func changeSize() {
        let currentSize = self.font.pointSize
        if (UIScreen.main.bounds.height == 667){
            self.font = self.font.withSize(currentSize-2)
        }
        else if (UIScreen.main.bounds.height == 568){
            self.font = self.font.withSize(currentSize-3)
        }
    }
}
