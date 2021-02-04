//
//  AppDIContainer+DetailModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 19/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension AppDIContainer:DetailModuleFactory {
    
     func createDetailViewController(detailRequestValue:DetailRequestValue) -> UIViewController {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DefaultDetailView")
            as? DefaultDetailView {
            vc.presenter = createDetailPresenter(detailRequestValue: detailRequestValue)
            return vc
        }
        return DefaultDetailView()
    }
    
    private func createDetailPresenter(detailRequestValue:DetailRequestValue) -> DetailPresenter {
        let presenter = DefaultDetailPresenter(
            requestValue:detailRequestValue,
            detailRouter: self.createDetailRouter(),
            fetchDetailGameUseCase : self.makeFetchDetailGameUseCase(),
            fetchScreenShotUseCase : self.makeFetchScreenShotUseCase(),
            addFavoriteUseCase: self.makeAddFavoriteUseCase()
        )
        
        return presenter
    }
    
    private func createDetailRouter() -> DetailRouter {
        let router = DefaultDetailRouter(factory:self, rootVc: self)
        return router
    }
    
}
