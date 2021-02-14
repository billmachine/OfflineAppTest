//
//  DefaultFavoritePresenter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 31/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxCocoa
import RxSwift
import GamePackage

struct FavoriteRequestValue {
}

class DefaultFavoritePresenter {
    var requestValue: FavoriteRequestValue
    var router: FavoriteRouter?
    var displayedGames  = BehaviorRelay<[GameDomain]>(value: [])
    
    var fetchFavoriteUseCase : FetchFavoriteUseCase
    var deleteFavoriteUseCase : DeleteFavoriteUseCase
    
    init(requestValue:FavoriteRequestValue,
         favoriteRouter:FavoriteRouter,
         useCase:UseCaseFactory
    ) {
        
        self.requestValue = requestValue
        self.router = favoriteRouter
        self.fetchFavoriteUseCase = useCase.makeFetchFavoriteUseCase()
        self.deleteFavoriteUseCase = useCase.makeDeleteFavoriteUseCase()
        getFavorites()
        
    }
}

extension DefaultFavoritePresenter : FavoritePresenter {
   
    func didDelete(_ game: GameDomain) {
       _ = self.deleteFavoriteUseCase.execute(requestValue: DeleteFavoriteUseCaseRequestValue(game: game))
            .subscribe(
                onNext: {_ in
                    self.getFavorites()
                })
    }
    
    func viewWillAppear() {
        getFavorites()
    }
    
    func didSelect(_ game: GameDomain) {
        self.router?.showDetail(game: game)
    }
    
    func getFavorites() {
        _ = fetchFavoriteUseCase.execute(requestValue:  FetchFavoriteUseCaseRequestValue()) {
            _ = $0.subscribe {
                if let favorites = $0.element {
                    self.displayedGames.accept(favorites)
                    }
                }
            }
    }
    
}
