//
//  GameRepository.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 14/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import RxSwift

protocol GameRepository {
    
    func getGames() -> Observable<[GameDomain]>
    func getGamebyId(id:String) -> Observable<GameDomain>
    func getbyPage(page:Int) -> Observable<[GameDomain]>
    func search(_word:String) -> Observable<[GameDomain]>
    func getScreenShotsbyId(id:String) -> Observable<[ScreenshotDomain]>

}
