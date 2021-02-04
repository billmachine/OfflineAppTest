//
//  FavoriteRouter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

protocol FavoriteRouter {
    
    var moduleRoute: ModuleFactory? { get set }
    func showDetail(game:GameDomain)
}
