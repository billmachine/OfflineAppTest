//
//  FavoriteRepository.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import RxSwift

final class DefaultFavoriteRepository: NSObject {
    fileprivate let locale: LocalFavoriteSource
    
    init(locale: LocalFavoriteSource) {
        self.locale = locale        
    }
  
}

extension DefaultFavoriteRepository: FavoriteRepository {
    
    func getFavoritebyId(from id: String) -> Observable<[GameDomain]> {
        return self.locale.getFavoritebyId(from: id)
            .map {
                $0.map {
                    $0.toDomain()
                }
            }
    }
    
    func getFavorites() -> Observable<[GameDomain]> {
        return self.locale.getFavorites()
            .map {
                $0.map {
                    $0.toDomain()
                }
            }
    }
    
    func addFavorite(from game: GameDomain) -> Observable<Bool> {
        return self.locale.addFavorite(from: game.toEntity())
    }
    
    func deleteFavorite(from game: GameDomain) -> Observable<Bool> {
        return self.locale.deleteFavorite(from: game.toEntity())
    }
    
}
