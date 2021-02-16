//
//  MainModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 06/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

protocol MainModuleFactory: class {
    func createMainViewController(requestValue:MainRequestValue) -> UIViewController
}

public struct MainRequestValue {
    let listView: DefaultListView?
    let favoriteView : DefaultFavoriteView?
    let profileView : DefaultProfileView?
}

class MainModule {
    enum Instructor {
        case go
    }
    
    let vcFactory:MainModuleFactory
    var rootVc : UIViewController
    let moduleFactory:ModuleFactory
    
    init(factory:PresentationFactory,rootVc:UIViewController) {
        
        self.vcFactory = factory
        self.moduleFactory = factory
        self.rootVc = rootVc
        
    }
    func start(with instructor: Instructor) {
        switch instructor {
        case .go:
            let listRequestValue = ListRequestValue()
            let listVc =
                self.moduleFactory.instantiateListModule().createListViewController(listRequestValue: listRequestValue)
            
            let favoriteRequestValue = FavoriteRequestValue()
            let favoriteVc =
                self.moduleFactory.instantiateFavoriteModule().createFavoriteViewController(requestValue:favoriteRequestValue)
            
            let profileVc =
                self.moduleFactory.instantiateProfileModule()
                .createProfileViewController()
            
            let mainRequestValue = MainRequestValue(
                listView: listVc as? DefaultListView,
                favoriteView: favoriteVc as? DefaultFavoriteView,
                profileView: profileVc as? DefaultProfileView
            )
            
            let mainVc = vcFactory.createMainViewController(requestValue: mainRequestValue)
            mainVc.modalPresentationStyle = .overFullScreen
            self.rootVc.show(mainVc, sender: nil)
            
        }
    }
    
}
