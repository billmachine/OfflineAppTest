//
//  Game.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public final class GameEntity: Object {

    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionraw: String = ""
    @objc dynamic var slug: String = ""
    @objc dynamic var released: Date?
    @objc dynamic var bg_image: String =  ""  
    @objc dynamic var rating:Double = 0.0
    @objc dynamic var rating_top:Int = 0
    @objc dynamic var reviews_count:Int = 0
    
    var genres = List<GenreEntity>()
    var ss = List<ScreenshotEntity>()

    public override static func primaryKey() -> String? {
    return "id"
  }
}

 public extension GameEntity {
    
    func toDomain() -> GameDomain {
        
        return GameDomain(id: self.id,
                          name: self.name,
                          descriptionraw: self.descriptionraw,
                          slug: self.slug,
                          released: self.released,
                          bg_image: URL(string:bg_image) ,
                          rating: self.rating,
                          rating_top: self.rating_top,
                          reviews_count: self.reviews_count,
                          genres:self.genres.map({ $0.toDomain() }),
                          ss: self.ss.map({ $0.toDomain() }),
                          state: .idle
                          )
    }

}
