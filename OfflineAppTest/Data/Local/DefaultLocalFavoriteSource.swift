//
//  GameDatasource.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/12/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import FavoritePackage
import GamePackage
import CoreOfflineAppTestKit

 class DefaultLocalFavoriteSource: NSObject {

  private let realm: Realm?

   init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> DefaultLocalFavoriteSource = { realmDatabase in
    return DefaultLocalFavoriteSource(realm: realmDatabase)
  }

}

extension DefaultLocalFavoriteSource: LocalFavoriteSource {
    func getFavorites() -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
          if let realm = self.realm {
            let categories: Results<GameEntity> = {
              realm.objects(GameEntity.self)
                .sorted(byKeyPath: "id", ascending: true)
            }()
            observer.onNext(categories.toArray(ofType: GameEntity.self))
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func getFavoritebyId(from id: String) -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
          if let realm = self.realm {
            let game: Results<GameEntity> = {
              realm.objects(GameEntity.self).filter("id = \(id)")
            }()
            observer.onNext(game.toArray(ofType: GameEntity.self))
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func addFavorite(from game: GameEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let realm = self.realm {
            do {
              try realm.write {
                  realm.add(game, update: .all)
                observer.onNext(true)
                observer.onCompleted()
              }
            } catch {
              observer.onError(DatabaseError.requestFailed)
            }

          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func deleteFavorite(from game: GameEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                let game: Results<GameEntity> = {
                    realm.objects(GameEntity.self).filter("id = \(game.id)")
                }()
                do {
                    try realm.write {
                        realm.delete(game)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
        
}
