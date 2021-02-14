//
//  ProfileContainerComponent.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 02/02/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

class ProfileContainerComponent : UIViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    override func viewDidLoad() {
        setupView()
    }
}

extension ProfileContainerComponent {
    func setupView() {
        imgProfile.layer.borderWidth = 5.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        imgProfile.clipsToBounds = true
    }
}
