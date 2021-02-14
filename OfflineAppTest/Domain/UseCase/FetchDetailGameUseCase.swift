//
//  FetchDetailGameUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 30/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import GamePackage
import Foundation
import RxSwift

public protocol FetchDetailGameUseCase {
    func execute(requestValue: FetchDetailGameUseCaseRequestValue) -> Observable<GameDomain>
}

public struct FetchDetailGameUseCaseRequestValue {
    let id: String
}

public final class DefaultFetchDetailGameUseCase {
    private let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
}

extension DefaultFetchDetailGameUseCase:FetchDetailGameUseCase {
    public func execute(requestValue: FetchDetailGameUseCaseRequestValue) -> Observable<GameDomain> {
        gameRepository.getGamebyId(id: requestValue.id)
    }
    
}
