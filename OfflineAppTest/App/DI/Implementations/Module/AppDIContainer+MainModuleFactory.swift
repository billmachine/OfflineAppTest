//
//  AppDIContainer+MainModuleFactory.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 17/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension AppDIContainer:MainModuleFactory {
    
    func createMainViewController(requestValue:MainRequestValue) -> UIViewController {
        var tabGames : UINavigationController {
            let listView = requestValue.listView
            listView?.tabBarItem = UITabBarItem(title: "Game", image: UIImage(named: "ic_game.png"), tag: 0)
            return UINavigationController(rootViewController: listView ?? UIViewController())
        }
        var tabFavorite : UINavigationController {
            let favoriteView = requestValue.favoriteView
            favoriteView?.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "ic_love"), tag: 0)
            return UINavigationController(rootViewController: favoriteView ?? UIViewController())
        }
        var tabProfile : UINavigationController {
            let profileView = requestValue.profileView
            profileView?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_user"), tag: 0)
            return UINavigationController(rootViewController: profileView ?? UIViewController())
        }
        var tabBar: UITabBarController {
            let tabs = mainStoryboard.instantiateViewController(withIdentifier: "GameTabBarController") as? UITabBarController
            tabs?.viewControllers = [tabGames,tabFavorite,tabProfile]
            tabs?.tabBar.tintColor = .dummyColor
            tabs?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return tabs ?? UITabBarController()
        }
        
        return tabBar
    }
    
}
