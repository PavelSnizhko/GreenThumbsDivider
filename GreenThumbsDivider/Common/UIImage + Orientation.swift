//
//  UIImage + Orientation.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//

import UIKit

extension UIImage {
    
    func fixOrientation() -> UIImage {
        if (self.imageOrientation == .up) {
            return self
        }
            
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: rect)
            
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
            
       return normalizedImage
    }
    
}

