//
//  ScreenshotEntity.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public final class ScreenshotEntity: Object {
    @objc dynamic var image: String?
 
}
 extension ScreenshotEntity {

    func toDomain() -> ScreenshotDomain {
        return ScreenshotDomain(image: URL(string:image ?? ""))
    }
}
