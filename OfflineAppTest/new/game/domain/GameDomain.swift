//
//  GameDomain.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public struct GameDomain {

    var id: Int
    var name: String
    var descriptionraw: String
    var slug: String
    var released: Date?
    var bg_image: URL?
    var rating:Double
    var rating_top:Int
    var reviews_count:Int
    var genres:[GenreDomain]
    var ss:[ScreenshotDomain]

    var state: DownloadState// = .loading //addendum
    
}

extension GameDomain {
    init() {
        self.id = -1
        self.name = ""
        self.descriptionraw = ""
        self.slug = ""
        self.released = nil
        self.bg_image = nil
        self.rating = 0.0
        self.rating_top = 0
        self.reviews_count = 0
        self.genres = []
        self.ss = []
        self.state = .loading
    }

    func toEntity() -> GameEntity {
        
        let game = GameEntity()
        game.id = self.id
        game.name = self.name
//        game.descriptionraw = self.descriptionraw
        game.slug = self.slug
        game.released = self.released
        
        game.bg_image =  self.bg_image?.absoluteString ?? ""
        game.rating = self.rating
        game.rating_top = self.rating_top
        game.reviews_count = self.reviews_count
        
        let listGenres = List<GenreEntity>()
        _ = self.genres.map { listGenres.append($0.toEntity()) }
        game.genres = listGenres
            
        let listSs = List<ScreenshotEntity>()
        _ = self.ss.map { listSs.append($0.toEntity()) }
        game.ss = listSs
        
        return game

    }
}
