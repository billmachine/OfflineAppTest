//
//  FavoriteRepository.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 14/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteRepository {
    
    func getFavorites() -> Observable<[GameDomain]>
    func addFavorite(from game: GameDomain) -> Observable<Bool>
    func getFavoritebyId(from id: String) -> Observable<[GameDomain]>
    func deleteFavorite(from game: GameDomain) -> Observable<Bool>

}
