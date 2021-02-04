//
//  Colors.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit

extension UIColor {
    static let dummyColor = Helper.hexStringToUIColor(hex:"#ba000d")
    
    func isLight() -> Bool {
            guard let components = cgColor.components else { return false }
            let redBrightness = components[0] * 299
            let greenBrightness = components[1] * 587
            let blueBrightness = components[2] * 114
            let brightness = (redBrightness + greenBrightness + blueBrightness) / 1000
            return brightness > 0.5
        }
    
}
