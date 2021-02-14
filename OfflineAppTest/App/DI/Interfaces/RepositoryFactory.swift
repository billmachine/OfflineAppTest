//
//  RepositoryFactory.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import FavoritePackage
import GamePackage

protocol RepositoryFactory {
    func makeFavoriteRepository() -> FavoriteRepository
    func makeGameRepository() -> GameRepository
}
