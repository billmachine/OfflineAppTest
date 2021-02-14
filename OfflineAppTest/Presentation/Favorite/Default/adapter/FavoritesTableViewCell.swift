//
//  FavoritesTableViewCell.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 24/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
import MaterialComponents
import GamePackage

class FavoritesTableViewCell: UITableViewCell {
    static let identifier = String(describing: FavoritesTableViewCell.self)
    
    @IBOutlet weak var txtSubtitle: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var cardContentView: UIView!
    
    var actionDelete : ( () -> Void )?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardContentView.layer.shadowColor = UIColor.lightGray.cgColor
        cardContentView.layer.shadowOpacity = 0.1
        cardContentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardContentView.layer.shadowRadius = 1.0
        cardContentView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        actionDelete?()
    }
    func fill(favorite:GameDomain) {

        SDWebImageManager.shared.loadImage(
            with: favorite.bg_image,
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
            self.imgPhoto.image = image
            self.imgPhoto.sd_imageIndicator = nil
            self.imgPhoto.sd_imageIndicator = .none
        }
        
        txtTitle.text = favorite.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        var date = ""
        if let dateNil = favorite.released {
            date = dateFormatter.string(from: dateNil)
        }
        txtSubtitle.text = date
        
        starRating.settings.fillMode = .precise
        starRating.settings.updateOnTouch = false
        starRating.rating = favorite.rating 

    }
    
}
