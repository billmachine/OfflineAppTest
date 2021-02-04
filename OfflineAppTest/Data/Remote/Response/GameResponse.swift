//
//  Game.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import UIKit


class GameResponse: Codable,ReflectedStringConvertible {
    var id: Int?
    var name: String?
    var slug: String?
    var released: String?
    var bg_image: String?
    var rating:Double?
    var rating_top:Int?
    var reviews_count:Int?
    var genres:[GenreResponse]?
    var ss:[ScreenshotResponse]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case released
        case bg_image = "background_image"
        case rating
        case rating_top
        case reviews_count
        case genres
        case ss = "short_screenshots"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id) 
        
        name = try container.decode(String?.self, forKey: .name) ?? ""
        
        slug = try container.decode(String?.self, forKey: .slug) ?? ""
        
        released = try container.decode(String?.self, forKey: .released) ?? ""
        
        bg_image = try container.decode(String?.self, forKey: .bg_image) ?? ""
        
        rating = try container.decode(Double?.self, forKey: .rating) ?? 0.0
        
        rating_top = try container.decode(Int?.self, forKey: .rating_top) ?? 0
        
        reviews_count = try container.decode(Int?.self, forKey: .reviews_count) ?? 0
        
        genres = try container.decode([GenreResponse]?.self, forKey: .genres) ?? []
        
        do {
            ss = try container.decode([ScreenshotResponse]?.self, forKey: .ss) ?? []
        } catch { ss = [] }
        
    }
    
}

extension GameResponse {
    
    func toDomain() -> GameDomain {
        let genre_domain = self.genres.map { $0.map { $0.toDomain() } }
        
        let ss_domain = self.ss.map { $0.map { $0.toDomain() } }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = Date()
        if let getDateNil = self.released {
            date = dateFormatter.date(from: getDateNil) ?? Date()
        }
        let released_domain = date
        
        let bg_image_domain = URL(string:bg_image ?? "") //??  nil
        
        return GameDomain(id: self.id!,
                          name: self.name!,
                          slug: self.slug!,
                          released: released_domain,
                          bg_image: bg_image_domain,
                          rating: self.rating!,
                          rating_top: self.rating_top!,
                          reviews_count: self.reviews_count!,
                          genres:genre_domain!,
                          ss: ss_domain!,
                          state: .idle
                          )
    }
    
}
