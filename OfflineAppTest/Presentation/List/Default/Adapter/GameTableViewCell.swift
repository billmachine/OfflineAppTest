//
//  GameTableViewCell.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit
import Cosmos
import MaterialComponents
import SDWebImage
import GamePackage

class GameTableViewCell: UITableViewCell {
    static let identifier = String(describing: GameTableViewCell.self)
    
    @IBOutlet weak var contentCard: UIView!
    @IBOutlet weak var listImg: UIImageView!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var ratingCosmos: CosmosView!
    @IBOutlet weak var listRelease: UILabel!
    @IBOutlet weak var cardView: MDCCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 20
        setupCardView()
    }
    
    func setupCardView() {
        contentCard.layer.shadowColor = UIColor.lightGray.cgColor
        contentCard.layer.shadowOpacity = 0.8
        contentCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        contentCard.layer.shadowRadius = 6.0
        contentCard.layer.masksToBounds = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
 
    func fill(game:GameDomain) {
        self.listTitle.text = game.name

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        var date = ""
        if let dateNil = game.released {
            date = dateFormatter.string(from: dateNil)
            self.listRelease.text = "\(date)"
        }

        self.ratingCosmos.settings.fillMode = .precise
        self.ratingCosmos.settings.updateOnTouch = false
        self.ratingCosmos.rating = game.rating
        self.ratingCosmos.settings.totalStars = game.rating_top

        self.listImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        self.listImg.image = UIImage(named: "ic_placeholder")
        SDWebImageManager.shared.loadImage(
            with: game.bg_image,
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
            self.listImg.image = image
            self.listImg.sd_imageIndicator = nil
            self.listImg.sd_imageIndicator = .none
        }
    }
    
}
