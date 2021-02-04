//
//  AppDiContainer+List.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 10/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation

extension AppDIContainer : ModuleFactory {
    func instantiateMainModule() -> MainModule {
        return .init(factory: self,rootVc: self.navigationController)
    }
    
    func instantiateListModule() -> ListModule {
        return .init(factory: self,rootVc: self.navigationController)
    }
    
    func instantiateFavoriteModule() -> FavoriteModule {
        return .init(factory: self,rootVc: self.navigationController)
    }
    
    func instantiateDetailModule() -> DetailModule {
        return .init(factory: self,rootVc: self.navigationController)
    }
    
    func instantiateProfileModule() -> ProfileModule {
        return .init(factory: self,rootVc: self.navigationController)
    }

}
