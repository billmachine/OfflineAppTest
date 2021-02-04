//
//  DetailPresenter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 19/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import RxCocoa


protocol DetailPresenterInput: class {
    func viewDidAppear()
    func didVisit()
    func didAddFavorite()
}

protocol DetailPresenterOutput: class {
    var displayedDetailGame: BehaviorRelay<GameDomain?> { get }
    var displayedScreenShots: BehaviorRelay<[ScreenshotDomain]> { get }
    var displayedGenres: BehaviorRelay<[GenreDomain]> { get }
    var loadState: BehaviorRelay<DownloadState> { get }
    var addFavoriteState: BehaviorRelay<DownloadState> { get }
}

protocol DetailPresenter: DetailPresenterOutput,DetailPresenterInput {
    var router: DetailRouter? { get set}
}
