//
//  AppDIContainer+FavoriteModuleFactory.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 31/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension AppDIContainer:FavoriteModuleFactory {
    
    func createFavoriteViewController(requestValue:FavoriteRequestValue) -> UIViewController {
        let view = DefaultFavoriteView()
        view.presenter = createFavoritePresenter(favoriteRequestValue: requestValue)
        return view
    }
    
    private func createFavoritePresenter(favoriteRequestValue:FavoriteRequestValue) -> FavoritePresenter {
        let presenter = DefaultFavoritePresenter(
            requestValue:favoriteRequestValue,
            favoriteRouter: self.createFavoriteRouter(),
            useCase: self
        )
        return presenter
    }
    
    private func createFavoriteRouter() -> FavoriteRouter {
        let router = DefaultFavoriteRouter(factory:self, rootVc: self)
        return router
    }
    
}
