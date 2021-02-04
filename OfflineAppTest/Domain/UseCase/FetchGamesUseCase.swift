//
//  FetchGamesUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 20/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift

public protocol FetchGamesUsecase {
    
    func execute(
        requestValue: FetchGamesUsecaseRequestValue) -> Observable<[GameDomain]>
} 

public struct FetchGamesUsecaseRequestValue {}

public final class DefaultFetchGamesUsecase {
    
    private let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    
}

extension DefaultFetchGamesUsecase:FetchGamesUsecase {
    public func execute(requestValue: FetchGamesUsecaseRequestValue) -> Observable<[GameDomain]> {
        gameRepository.getGames()
    }
    
}
