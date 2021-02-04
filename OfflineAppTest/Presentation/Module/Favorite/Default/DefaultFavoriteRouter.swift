//
//  DefaultFavoriteRouter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 31/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit


class DefaultFavoriteRouter {

    var moduleRoute: ModuleFactory?
    var rootVc: UIViewController?
    
    init(factory:PresentationFactory,rootVc:AppDIContainer) {
        self.moduleRoute = factory
        self.rootVc = rootVc.navigationController
    }
}

extension DefaultFavoriteRouter: FavoriteRouter {
    func showDetail(game:GameDomain) {
        let param = DetailRequestValue(
            game:game
        )
        
        self.moduleRoute?.instantiateDetailModule()
            .start(with: .go(requestValue: param))
    }
}
