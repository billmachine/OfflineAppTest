//
//  Genre.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation

public final class GenreResponse: Codable {
    let name: String?
}

public extension GenreResponse {
    func toDomain() -> GenreDomain {
        return GenreDomain(name: self.name)
    }
}
