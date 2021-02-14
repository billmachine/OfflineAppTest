//
//  DeleteFavoriteUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 02/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
import FavoritePackage
import GamePackage

public protocol DeleteFavoriteUseCase {
    func execute(requestValue: DeleteFavoriteUseCaseRequestValue) -> Observable<Bool>
}

public struct DeleteFavoriteUseCaseRequestValue {
    let game: GameDomain
}

public final class DefaultDeleteFavoriteUseCase {
    private let favoriteRepository: FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
}

extension DefaultDeleteFavoriteUseCase:DeleteFavoriteUseCase {
    
    public func execute(requestValue: DeleteFavoriteUseCaseRequestValue) -> Observable<Bool> {
        return favoriteRepository.deleteFavorite(from: requestValue.game)
    }
    
}
