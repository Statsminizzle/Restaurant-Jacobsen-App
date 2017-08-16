//
//  PlaceholderColorExtension.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 15/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var placeholderColor: UIColor? {
        get {
            if let attributedString = self.attributedPlaceholder?.attributedSubstring(from: NSMakeRange(0, 1)) {
                let color = attributedString.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil) as! UIColor
                return color
            } else {
                return nil
            }
        }
        
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: newValue!])
        }
    }
}
