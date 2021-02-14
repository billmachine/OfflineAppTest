//
//  FetchFavoriteUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 15/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
import FavoritePackage
import GamePackage

public protocol FetchFavoriteUseCase {

    func execute(
        requestValue: FetchFavoriteUseCaseRequestValue,
        completion: @escaping (Observable<[GameDomain]>) -> Void
    )

}

public struct FetchFavoriteUseCaseRequestValue {}

public final class DefaultFetchFavoriteUseCase {
    
    private let favoriteRepository: FavoriteRepository
    
     init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
}

extension DefaultFetchFavoriteUseCase:FetchFavoriteUseCase {
    public func execute(requestValue: FetchFavoriteUseCaseRequestValue, completion: @escaping (Observable<[GameDomain]>) -> Void) {
        completion(favoriteRepository.getFavorites())
    }
    
}
