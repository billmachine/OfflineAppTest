//
//  SSCollectionViewCell.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 24/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit


class SSCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: SSCollectionViewCell.self)
    @IBOutlet weak var ssImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
