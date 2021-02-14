//
//  ModuleFactory.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation

protocol ModuleFactory {
    func instantiateMainModule() -> MainModule
    func instantiateListModule() -> ListModule
    func instantiateDetailModule() -> DetailModule
    func instantiateFavoriteModule() -> FavoriteModule
    func instantiateProfileModule() -> ProfileModule
    }
