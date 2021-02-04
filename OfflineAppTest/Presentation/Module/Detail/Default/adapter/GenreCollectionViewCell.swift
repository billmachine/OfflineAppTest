//
//  GenreCollectionViewCell.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 24/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit


class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GenreCollectionViewCell.self)
    @IBOutlet weak var txtGenre: UILabel!
       @IBOutlet weak var roundView: RoundButton!
       
       override func awakeFromNib() {
           super.awakeFromNib()
           roundView.layer.borderColor = UIColor.red.cgColor
       }

}
