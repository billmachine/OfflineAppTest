//
//  GenreEntity.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import RealmSwift

class GenreEntity: Object {
   @objc dynamic var name: String = ""
}

extension GenreEntity {
    func toDomain() -> GenreDomain {
        return GenreDomain(name: self.name)
    }
}
