//
//  AppDiContainer+UseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 15/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation

extension AppDIContainer : UseCaseFactory {
    func makeFetchDetailGameUseCase() -> FetchDetailGameUseCase {
        return DefaultFetchDetailGameUseCase(gameRepository: self.makeGameRepository())
    }
    
    func makeFetchScreenShotUseCase() -> FetchScreenShotUseCase {
        return DefaultFetchScreenShotUseCase(gameRepository: self.makeGameRepository())
    }
    
    func makeFetchGamesUseCase() -> FetchGamesUsecase {
        return DefaultFetchGamesUsecase(gameRepository: self.makeGameRepository())
    }
    
    func makeFetchGamesbyPageUseCase() -> FetchGamesbyPageUseCase {
        return DefaultFetchGamesbyPageUseCase(gameRepository: self.makeGameRepository())
    }
    
    func makeSearchGameUseCase() -> SearchGameUseCase {
        return DefaultSearchGameUseCase(gameRepository: self.makeGameRepository())
    }
    
    func makeAddFavoriteUseCase() -> AddFavoriteUseCase {
        return DefaultAddFavoriteUseCase(favoriteRepository: self.makeFavoriteRepository())
    }
    
    func makeFetchFavoriteUseCase() -> FetchFavoriteUseCase {
        return DefaultFetchFavoriteUseCase(favoriteRepository: self.makeFavoriteRepository())
    }
    
    func makeDeleteFavoriteUseCase() -> DeleteFavoriteUseCase {
        return DefaultDeleteFavoriteUseCase(favoriteRepository: self.makeFavoriteRepository())
    }
    
}
