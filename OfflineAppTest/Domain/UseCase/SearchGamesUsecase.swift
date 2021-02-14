//
//  SearchGamesUsecase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 28/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
import Foundation
import GamePackage

public protocol SearchGameUseCase {
    func execute(requestValue: SearchGameUseCaseRequestValue) -> Observable<[GameDomain]>
}

public struct SearchGameUseCaseRequestValue {
    let word: String
}

public final class DefaultSearchGameUseCase {
    private let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
}

extension DefaultSearchGameUseCase:SearchGameUseCase {
    public func execute(requestValue: SearchGameUseCaseRequestValue) -> Observable<[GameDomain]> {
        gameRepository.search(_word: requestValue.word)
    }
    
}
