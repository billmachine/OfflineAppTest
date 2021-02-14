//
//  DefaultListRouter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import GamePackage

class DefaultListRouter {

    var moduleRoute: ModuleFactory? 
    weak var rootVc: UIViewController?
    
    init(factory:PresentationFactory,rootVc:AppDIContainer) {
        self.moduleRoute = factory
        self.rootVc = rootVc.navigationController
    }
}

extension DefaultListRouter: ListRouter {
    func showDetail(game:GameDomain) {
        let param = DetailRequestValue(
            game:game
        )
        
        self.moduleRoute?.instantiateDetailModule()
            .start(with: .go(requestValue: param))
    }
   
}
