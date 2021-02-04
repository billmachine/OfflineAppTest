//
//  AddFavoriteUseCase.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 31/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift


public protocol AddFavoriteUseCase {
    func execute(requestValue: AddFavoriteUseCaseRequestValue) -> Observable<Bool>
}

public struct AddFavoriteUseCaseRequestValue {
    let game: GameDomain
}

public final class DefaultAddFavoriteUseCase {
    private let favoriteRepository: FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
}

extension DefaultAddFavoriteUseCase:AddFavoriteUseCase {
    public func execute(requestValue: AddFavoriteUseCaseRequestValue) -> Observable<Bool> {
        
        return Observable<Bool>.create { observer in
            
            let observableCheck = self.checkById(id: "\(requestValue.game.id)")
            let observableInsert = self.addGame(game:requestValue.game)
             
            let check =
                Observable<Bool>.create { observer2 in
                    observableCheck.subscribe( onNext: { result in
                        if result.isEmpty {
                            observer2.onNext(true)
                        } else {
                            observer.onError(DatabaseError.requestFailed)
                        }
                    },onError: { error in
                        observer.onError(DatabaseError.requestFailed)
                    })
                    return Disposables.create()
                }
            
            let insert = Observable<Bool>.create { observer3 in
                observableInsert.subscribe( onNext: { result in
                        if result {
                            observer3.onNext(true)
                        } else {
                            observer3.onError(DatabaseError.requestFailed)
                        }
                    },onError: { error in
                        observer3.onError(DatabaseError.requestFailed)
                    })
                return Disposables.create()
            }
            
            check.flatMap { request -> Observable<Bool> in insert }
                .subscribe(onNext: { result in
                    observer.onNext(true)
                },
                onError: { error in
                    observer.onError(DatabaseError.requestFailed)
                }
            )
            
            return Disposables.create()
        }
    }
    
    func checkById(id:String) -> Observable<[GameDomain]> {
        return self.favoriteRepository.getFavoritebyId(from: id)
    }
    
    func addGame(game:GameDomain) -> Observable<Bool> {
        return self.favoriteRepository.addFavorite(from: game)
    }
    
}
