//
//  AppDIContainer+ProfileModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 02/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension AppDIContainer:ProfileModuleFactory {
    func createProfileViewController() -> UIViewController {
        let view = profileStoryboard.instantiateInitialViewController() as! UIViewController
        return view
    }
    
}
