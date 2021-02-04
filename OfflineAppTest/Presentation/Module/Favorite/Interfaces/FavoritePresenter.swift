//
//  FavoritePresenter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxSwift
import RxRelay


protocol FavoritePresenterInput: class {
    func viewWillAppear()
    func didSelect(_ game: GameDomain)
    func didDelete(_ game: GameDomain)
}

protocol FavoritePresenterOutput: class {
    var displayedGames: BehaviorRelay<[GameDomain]> { get }
     }

protocol FavoritePresenter: FavoritePresenterInput,FavoritePresenterOutput {
    var router: FavoriteRouter? { get set }
}
