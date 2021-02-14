//
//  LocalFavoriteSource.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 12/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalFavoriteSource: class {

  func getFavorites() -> Observable<[GameEntity]>
  func getFavoritebyId(from id: String) -> Observable<[GameEntity]>
  func addFavorite(from game: GameEntity) -> Observable<Bool>
  func deleteFavorite(from game: GameEntity) -> Observable<Bool>

}
