//
//  DefaultProfileView+Setup.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 02/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension DefaultProfileView {
    func setupNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,.font:UIFont.systemFont(ofSize: 25,weight: .bold)]
            navBarAppearance.backgroundColor = Colors.colorPrimary
            navBarAppearance.shadowColor = .clear
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationItem.title = "Profil"
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            
            self.navigationController?.navigationBar.barTintColor = Colors.colorPrimary
            self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        }
        
    }
}
