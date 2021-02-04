//
//  FetchGamesbyPageUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 26/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
import Foundation


public protocol FetchGamesbyPageUseCase {
    func execute(requestValue: FetchGamesbyPageUseCaseRequestValue) -> Observable<[GameDomain]>
}

public struct FetchGamesbyPageUseCaseRequestValue {
    let page: Int
}

public final class DefaultFetchGamesbyPageUseCase {
    private let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
}

extension DefaultFetchGamesbyPageUseCase:FetchGamesbyPageUseCase {
    public func execute(requestValue: FetchGamesbyPageUseCaseRequestValue) -> Observable<[GameDomain]> {
        gameRepository.getbyPage(page: requestValue.page)
    }
    
}
