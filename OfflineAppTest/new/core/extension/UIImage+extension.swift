//
//  UIImage+extension.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit

extension UIImage {
    func imgToData() -> Data? {
        return self.jpegData(compressionQuality: 1)
    }
}
