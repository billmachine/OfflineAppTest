//
//  DefaultFavoriteView+ext.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 01/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension DefaultFavoriteView {
func setupNavbar() {
    let textColor  = UIColor.white
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.tintColor = textColor
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.backgroundColor = Colors.colorPrimary
        
        navBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    } else {
        self.navigationController?.navigationBar.barTintColor = Colors.colorPrimary
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    
    let backButton = UIBarButtonItem()
    backButton.title = "Back"
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

    let navbarBgSubview = navigationController?.navigationBar.subviews.first
    navbarBgSubview?.alpha = 1.0
    
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.isTranslucent = false
    
    if #available(iOS 13.0, *) {
        self.navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    setNeedsStatusBarAppearanceUpdate()
    
}

}
