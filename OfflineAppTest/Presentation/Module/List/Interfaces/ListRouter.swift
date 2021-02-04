//
//  ListRouter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

protocol ListRouter {
    
    var moduleRoute: ModuleFactory? { get set }
    
    func showDetail(game:GameDomain)
}
