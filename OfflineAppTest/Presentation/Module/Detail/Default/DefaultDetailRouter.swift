//
//  DefaultDetailRouter.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 19/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit


class DefaultDetailRouter {

    var moduleRoute: ModuleFactory?
    var rootVc: UIViewController?
    
    init(factory:PresentationFactory,rootVc:AppDIContainer) {
        self.moduleRoute = factory
        self.rootVc = rootVc.navigationController
    }
}

extension DefaultDetailRouter: DetailRouter {
    
}
