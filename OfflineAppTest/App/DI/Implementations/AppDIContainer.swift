//
//  AppDIContainer.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import GamePackage
import FavoritePackage

typealias PresentationFactory = ModuleFactory & ViewControllerFactory
typealias ViewControllerFactory =
    ListModuleFactory &
    FavoriteModuleFactory &
    MainModuleFactory &
    DetailModuleFactory &
    ProfileModuleFactory
    
final class AppDIContainer {
    
    let navigationController: UIViewController
    
    lazy var realmStorage = RealmStorage.sharedInstance.realm
    lazy var localFavoriteSource: LocalFavoriteSource = DefaultLocalFavoriteSource(realm: realmStorage)
    lazy var remoteDataSource: RemoteGameSource = DefaultRemoteGameSource()
    
    var mainStoryboard: UIStoryboard {
          return UIStoryboard(name: "Main", bundle: Bundle.main)
      }
    var profileStoryboard: UIStoryboard {
          return UIStoryboard(name: "Profile", bundle: Bundle.main)
      }
    
    init(navigationController: UIViewController) {
        self.navigationController = navigationController
    }
    
}
