//
//  MColor.swift
//  InstagramClone
//
//  Created by Mustafa on 22.02.2022.
//

import Foundation
import UIKit

extension UIColor {
    
    // Static tanımlamamızın amacı . ya basınca fonksiyonu çağırabilmek
    
    static func convertRgb(red : CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
