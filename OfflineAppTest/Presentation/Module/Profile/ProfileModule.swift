//
//  ProfileModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 09/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit


protocol ProfileModuleFactory: class {
     func createProfileViewController() -> UIViewController
}

class ProfileModule {
    enum Instructor {
        case go
    }
    
    let vcFactory:ProfileModuleFactory?
    var rootVc : UIViewController?
    
    init(factory:PresentationFactory,rootVc:UIViewController) {
        self.vcFactory = factory
        self.rootVc = rootVc
        
    }
    func start(with instructor: Instructor) {
        switch instructor {
        case .go:
            let vc = createProfileViewController()
            rootVc?.present(vc!, animated: true, completion: {})
        }
        
    }
}

extension ProfileModule {
    public func createProfileViewController() -> UIViewController? {
        return self.vcFactory?.createProfileViewController()
    }
}
