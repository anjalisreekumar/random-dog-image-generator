//
//  Extensions.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 18/01/25.
//

import UIKit

extension UIButton {
    func setBlackBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    func setCurvedCorner() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
}

extension String {
    func sanitizeKey() -> String {
        var sanitizedString = self
        sanitizedString = sanitizedString.replacingOccurrences(of: "/", with: "_")
        sanitizedString = sanitizedString.replacingOccurrences(of: ":", with: "_")
        sanitizedString = sanitizedString.replacingOccurrences(of: ".", with: "_")
        return sanitizedString
    }
}
