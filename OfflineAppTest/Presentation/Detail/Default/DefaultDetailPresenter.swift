//
//  DefaultDetailPresenter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 19/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
import RxCocoa
import FavoritePackage
import GamePackage
import CoreOfflineAppTestKit
import CategoryPackage
import UIKit

public struct DetailRequestValue {
    var game : GameDomain
}

public class DefaultDetailPresenter {
    let requestValue: DetailRequestValue
    var router: DetailRouter?
    
    var disposeBag = DisposeBag()
    
    var displayedDetailGame = BehaviorRelay<GameDomain?>(value:nil)
    var loadState = BehaviorRelay<DownloadState>(value:.idle)
    var addFavoriteState = BehaviorRelay<DownloadState>(value:.idle)
    
    var displayedScreenShots = BehaviorRelay<[ScreenshotDomain]>(value:[])
    var displayedGenres = BehaviorRelay<[GenreDomain]>(value:[])
    
    var fetchDetailGameUseCase: FetchDetailGameUseCase?
    var fetchScreenShotUseCase: FetchScreenShotUseCase?
    var addFavoriteUseCase:AddFavoriteUseCase?
    
    init(requestValue:DetailRequestValue,
         detailRouter:DetailRouter,
         fetchDetailGameUseCase:FetchDetailGameUseCase,
         fetchScreenShotUseCase:FetchScreenShotUseCase,
         addFavoriteUseCase:AddFavoriteUseCase
    ) {
        self.requestValue = requestValue
        self.router = detailRouter
        self.fetchDetailGameUseCase = fetchDetailGameUseCase
        self.fetchScreenShotUseCase = fetchScreenShotUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        
        getGamebyId(id: self.requestValue.game.id)
        getScreenShotById(id: "\(self.requestValue.game.id)")
      
    }
    
}

extension DefaultDetailPresenter: DetailPresenter {
    
    func didAddFavorite() {
        _ = addFavoriteUseCase?.execute(requestValue: AddFavoriteUseCaseRequestValue(game: requestValue.game))
            .subscribe(
            onNext: { state in
                if state == true {
                    self.addFavoriteState.accept(.success)
                } else {
                    self.addFavoriteState.accept(.error)
                }
            },
            onError: { error in
                self.addFavoriteState.accept(.error)
            },
            onCompleted: {
                self.addFavoriteState.accept(.idle)
            }
            )
    }
    
    func didVisit() {
       let url = URL(string: "\(ApiUrl.visitUrl)/\(requestValue.game.slug )")
        UIApplication.shared.open(url!)
    }
    
    func viewDidAppear() {}
    
    func getGamebyId(id:Int) {
        DispatchQueue.global(qos:.background).async {
            self.loadState.accept(.loading)
            self.fetchDetailGameUseCase?.execute(requestValue: FetchDetailGameUseCaseRequestValue(id: "\(id)"))
                .subscribe( onNext: { result in
                    self.loadState.accept(.success)
                    self.displayedDetailGame.accept(result)
                    self.displayedGenres.accept(result.genres)
                }
                ,onError: { error in
                    self.loadState.accept(.error)
                }
                ,onCompleted: {}
                ,onDisposed: {}).disposed(by: self.disposeBag)
        }
    }
    
    func getScreenShotById(id:String) {
        DispatchQueue.global(qos:.background).async {
            _ = self.fetchScreenShotUseCase?.execute(requestValue: FetchScreenShotUseCaseRequestValue(id: id))
                .subscribe { result in
                    if let screenshot = result.element {
                        self.displayedScreenShots.accept(screenshot)
                    }
                }
        }
    }
    
}
