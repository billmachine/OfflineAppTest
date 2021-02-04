//
//  Screenshot.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit

class ScreenshotResponse: Codable,ReflectedStringConvertible {
    var image: String?

    enum CodingKeys: String, CodingKey {
        case image
    }
    
     required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decode(String?.self, forKey: .image)
        
    }
}

extension ScreenshotResponse {
    func toDomain() -> ScreenshotDomain {
        let bg_image_domain = URL(string:image ?? "") 
        return ScreenshotDomain(image: bg_image_domain)
    }
}
