//
//  AppDIContainer+ListModule.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 16/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
// 

import UIKit

extension AppDIContainer:ListModuleFactory {
    
    func createListViewController(listRequestValue:ListRequestValue) -> UIViewController {
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clear // Whatever color you like
        UITableViewCell.appearance().selectedBackgroundView = clearView
        
        let view = DefaultListView(with: createListPresenter(listRequestValue: listRequestValue))
        return view
    }
    
    private func createListPresenter(listRequestValue:ListRequestValue) -> ListPresenter {
        let presenter = DefaultListPresenter(
            requestValue:listRequestValue,
            listRouter: self.createListRouter(),
            useCase: self
        )
        return presenter
    }
    
    private func createListRouter() -> ListRouter {
        let router = DefaultListRouter(factory:self, rootVc: self)
        return router
    }
    
}
