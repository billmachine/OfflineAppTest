//
//  ListModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

protocol ListModuleFactory: class {
    func createListViewController(listRequestValue:ListRequestValue) -> UIViewController
}

class ListModule {
    enum Instructor {
        case go(requestValue: ListRequestValue)

    }
    
    let vcFactory:ListModuleFactory?
    let rootVc : UIViewController?
  
    init(factory:PresentationFactory,rootVc:UIViewController) {
        self.vcFactory = factory
        self.rootVc = rootVc 
    }
    
    func start(with instructor: Instructor) {
        switch instructor {
        case .go(let listRequestValue):
            let vc = createListViewController(listRequestValue: listRequestValue)
            rootVc?.present(vc!, animated: true, completion: {})
        }
    }
}

extension ListModule {
    public func createListViewController(listRequestValue:ListRequestValue) -> UIViewController? {
        return self.vcFactory?.createListViewController(listRequestValue:listRequestValue)
    }
}
