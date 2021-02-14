//
//  DefaultProfileView.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 02/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

class DefaultProfileView : UIViewController {
    
}
extension DefaultProfileView : ProfileView {
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
}
