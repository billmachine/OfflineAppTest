//
//  RemoteGameSource.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 12/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol RemoteGameSource: class {
    
    func getGames() -> Observable<[GameResponse]>
    func loadMoreGames(page:Int) -> Observable<[GameResponse]>
    func searchGames(from keyword: String) -> Observable<[GameResponse]>
    func getGamebyId(id:String) -> Observable<GameResponse>
    func getScreenShotsbyId(id:String) -> Observable<[ScreenshotResponse]>
    
}
