//
//  AppDiContainer+Repository.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 14/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation

extension AppDIContainer : RepositoryFactory {
    func makeFavoriteRepository() -> FavoriteRepository {
        return DefaultFavoriteRepository(locale: self.localFavoriteSource)
    }
    
    func makeGameRepository() -> GameRepository {
        return DefaultGameRepository(remote: self.remoteDataSource)
    }
    
}
