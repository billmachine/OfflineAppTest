//
//  UseCaseFactory.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import GamePackage
import FavoritePackage

public protocol UseCaseFactory {
    func makeFetchFavoriteUseCase() -> FetchFavoriteUseCase 
    func makeFetchGamesUseCase() -> FetchGamesUsecase
    func makeFetchDetailGameUseCase() -> FetchDetailGameUseCase
    func makeFetchGamesbyPageUseCase() -> FetchGamesbyPageUseCase
    func makeSearchGameUseCase() -> SearchGameUseCase
    func makeFetchScreenShotUseCase() -> FetchScreenShotUseCase
    func makeAddFavoriteUseCase() -> AddFavoriteUseCase
    func makeDeleteFavoriteUseCase() -> DeleteFavoriteUseCase
}
