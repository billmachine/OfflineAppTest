//
//  FetchScreenShotUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 30/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift


public protocol FetchScreenShotUseCase {
    func execute(requestValue: FetchScreenShotUseCaseRequestValue) -> Observable<[ScreenshotDomain]>
}

public struct FetchScreenShotUseCaseRequestValue {
    let id: String
}

public final class DefaultFetchScreenShotUseCase {
    private let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
}

extension DefaultFetchScreenShotUseCase:FetchScreenShotUseCase {
    public func execute(requestValue: FetchScreenShotUseCaseRequestValue) -> Observable<[ScreenshotDomain]> {
        gameRepository.getScreenShotsbyId(id: requestValue.id)
    }
    
}
