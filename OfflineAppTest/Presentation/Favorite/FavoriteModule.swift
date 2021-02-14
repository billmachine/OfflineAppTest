//
//  FavoriteModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

protocol FavoriteModuleFactory: class {
    func createFavoriteViewController(requestValue:FavoriteRequestValue) -> UIViewController
}

class FavoriteModule {
    enum Instructor {
        case go(requestValue: FavoriteRequestValue)
    }
    
    let vcFactory:FavoriteModuleFactory?
    let rootVc : UIViewController?
    
    init(factory:PresentationFactory,rootVc:UIViewController) {
        self.vcFactory = factory
        self.rootVc = rootVc
    }
    
    func start(with instructor: Instructor) {
        switch instructor {
        case .go(let favoriteRequestValue):
            let vc = createFavoriteViewController(requestValue: favoriteRequestValue)
            rootVc?.present(vc!, animated: true, completion: {})
        }
    }
}

extension FavoriteModule {
    public func createFavoriteViewController(requestValue:FavoriteRequestValue) -> UIViewController? {
        return self.vcFactory?.createFavoriteViewController(requestValue:requestValue)
    }
}
