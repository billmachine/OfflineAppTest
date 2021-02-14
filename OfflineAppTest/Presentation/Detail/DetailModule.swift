//
//  DetailModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 06/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit 

protocol DetailModuleFactory: class {
     func createDetailViewController(detailRequestValue:DetailRequestValue) -> UIViewController
}

class DetailModule {
    
    enum Instructor {
        case go(requestValue: DetailRequestValue)
    }
    
    let vcFactory:DetailModuleFactory?
    let rootVc : UIViewController?
    let moduleFactory:ModuleFactory?
    
    init(factory:PresentationFactory,rootVc:UIViewController) {
        self.vcFactory = factory
        self.moduleFactory = factory
        self.rootVc = rootVc
    }
    
    func start(with instructor: Instructor) {
        switch instructor {
        case .go(let detailRequestValue):
            let vc = createDetailViewController(detailRequestValue: detailRequestValue)

            if let pushVc = rootVc?.presentedViewController as? UITabBarController? {
            pushVc?.selectedViewController?.show(vc!, sender: nil)
            }
        }
    }
    
}

extension DetailModule {
    public func createDetailViewController(detailRequestValue:DetailRequestValue) -> UIViewController? {
        return self.vcFactory?.createDetailViewController(detailRequestValue:detailRequestValue)
    }
}
