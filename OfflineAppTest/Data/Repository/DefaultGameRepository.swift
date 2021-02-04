//
//  GameRepository.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation 
import RxSwift

final class DefaultGameRepository: NSObject {
    
    fileprivate let remote: RemoteGameSource

     init(remote: RemoteGameSource) {
      self.remote = remote
    }

}

extension DefaultGameRepository : GameRepository {
    func getGames() -> Observable<[GameDomain]> {
        self.remote.getGames().map {
            return $0.map {
                return $0.toDomain()
            }
        }
    }
    
    func getGamebyId(id:String) -> Observable<GameDomain> {
        self.remote.getGamebyId(id: id).map {
            return $0.toDomain()
        }
    }
    
    func getbyPage(page: Int) -> Observable<[GameDomain]> {
        self.remote.loadMoreGames(page: page).map {
            $0.map {
                $0.toDomain()
            }
        }
    }
    
    func search(_word keword:String) -> Observable<[GameDomain]> {
        self.remote.searchGames(from: keword).map {
            $0.map {
                $0.toDomain()
            }
        }
    }
    
    func getScreenShotsbyId(id: String) -> Observable<[ScreenshotDomain]> {
        self.remote.getScreenShotsbyId(id: id).map {
            return $0.map {
                 $0.toDomain()
            }
        }
    }
    
}
