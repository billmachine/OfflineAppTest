//
//  DefaultListPresenter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
//import RxRelay
import RxCocoa
import CoreOfflineAppTestKit
import GamePackage
import Foundation

struct ListRequestValue {}

class DefaultListPresenter {
    var requestValue: ListRequestValue
    var router: ListRouter?
    var useCase: UseCaseFactory?
    
    var disposeBag = DisposeBag()
    
    private let fetchGamesUseCase: FetchGamesUsecase?
    private let fetchGamesbyPageUseCase: FetchGamesbyPageUseCase?
    private let searchGameUseCase: SearchGameUseCase?
    
    private var gamesHome: [GameDomain] = []
    private var gamesSearch: [GameDomain] = []
    
    var displayedGames  = BehaviorRelay<[GameDomain]>(value: [])
    
    var displayedState = BehaviorRelay<ListPageState>(value:.home)
    
    var loadMoreState = BehaviorRelay<DownloadState>(value:.idle)
    
    var searchState = BehaviorRelay<DownloadState>(value:.empty)
    
    class Constant {
        static let dummyGames : [GameDomain] = [GameDomain(),GameDomain(),GameDomain(),GameDomain(),GameDomain(),GameDomain(),GameDomain()]
        static let itemPerPage = 20
    }
    
    init(requestValue:ListRequestValue,
         listRouter:ListRouter,
         useCase:UseCaseFactory
    ) {
        
        self.requestValue = requestValue
        self.router = listRouter
        self.fetchGamesUseCase = useCase.makeFetchGamesUseCase()
        self.fetchGamesbyPageUseCase = useCase.makeFetchGamesbyPageUseCase()
        self.searchGameUseCase = useCase.makeSearchGameUseCase()
        getGames()
    }
    
}

extension DefaultListPresenter: ListPresenter {
    
    func viewWillAppear() {}
    
    func switchState(state:ListPageState) {
        DispatchQueue.global(qos:.background).async {
            self.disposeBag = DisposeBag()
            if state == .home {
                self.displayedGames.accept(self.gamesHome)
                self.displayedState.accept(.home)
            }
            
            if state == .search {
                self.displayedState.accept(.search)
                self.displayedGames.accept(self.gamesSearch)
                
                if self.gamesSearch.isEmpty {
                    self.searchState.accept(.idle)
                }
                
            }
        }
    }
    
    func reload() {
        self.getGames()
    }
    
    func didSelect(_ game:GameDomain) {
        router?.showDetail(game:game)
    }
    
    func getGames() {
        DispatchQueue.global(qos:.background).async {
            self.disposeBag = DisposeBag()
            if(self.gamesHome.isEmpty) {
                DispatchQueue.main.async {
                    self.displayedGames.accept(Constant.dummyGames)
                }
            }
            
            self.fetchGamesUseCase?.execute(requestValue: FetchGamesUsecaseRequestValue())
                .delay(.seconds(1), scheduler: MainScheduler.instance)
                .subscribe { result in
                    if let gameElement = result.element {
                        self.displayedGames.accept(gameElement)
                        self.gamesHome = gameElement
                    }
                }.disposed(by: self.disposeBag)
        }
    }
    
    func loadMore() {
        DispatchQueue.global(qos:.background).async {
            guard self.displayedState.value == .home else { return }
            guard self.loadMoreState.value == .idle else { return }
            
            self.disposeBag = DisposeBag()
            
            self.loadMoreState.accept(.loading)
            var currentGameswithDummy = self.gamesHome
            currentGameswithDummy.append(contentsOf: Constant.dummyGames)
            self.displayedGames.accept(currentGameswithDummy)
            
            let pageWillLoad = self.gamesHome.count / Constant.itemPerPage + 1
            
            self.fetchGamesbyPageUseCase?.execute(requestValue: FetchGamesbyPageUseCaseRequestValue(page:pageWillLoad))
                .subscribe { result in
                    
                    self.gamesHome.append(contentsOf: result.element ?? [])
                    
                    self.displayedGames.accept(self.gamesHome)
                    self.loadMoreState.accept(.idle)
                    
                }.disposed(by: self.disposeBag)
        }
    }
    
    func didSearch(_ word:String) {
        DispatchQueue.global(qos:.background).async {
            self.disposeBag = DisposeBag()
            
            self.searchState.accept(.loading)
            self.displayedGames.accept(Constant.dummyGames)
            
            self.searchGameUseCase?.execute(requestValue: SearchGameUseCaseRequestValue(word: word))
                .subscribe( onNext: { result in
                    self.searchState.accept(.success)
                    
                    self.gamesSearch = result 
                    self.displayedGames.accept(self.gamesSearch)
                    
                    if self.gamesSearch.isEmpty {
                        self.searchState.accept(.empty)
                    }
                    
                }
                ,onError: { error in
                    self.searchState.accept(.error)
                }
                ,onCompleted: { }
                ,onDisposed: { }
                )
                .disposed(by: self.disposeBag)
        }
    }
    
}
