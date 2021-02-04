//
//  ListPresenter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//
import RxSwift
import RxRelay


protocol ListPresenterInput: class {
    func viewWillAppear()
    func didSelect(_ game: GameDomain)
    func didSearch(_ word: String)
    func loadMore()
    func switchState(state:ListPageState)
    func reload()
}

protocol ListPresenterOutput: class {
    var displayedGames: BehaviorRelay<[GameDomain]> { get }
    var displayedState: BehaviorRelay<ListPageState> { get }
    var searchState: BehaviorRelay<DownloadState> { get }
     }

protocol ListPresenter: ListPresenterInput,ListPresenterOutput {
    var router: ListRouter? { get set }
}
