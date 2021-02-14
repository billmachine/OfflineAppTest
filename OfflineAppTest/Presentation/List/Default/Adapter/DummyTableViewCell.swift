//
//  DummyTableViewCell.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit
import SkeletonView

class DummyTableViewCell: UITableViewCell {
    static let identifier = String(describing: DummyTableViewCell.self)
    
    @IBOutlet weak var titleDummy: UILabel!
    @IBOutlet weak var imageDummy: UIImageView!
    @IBOutlet weak var releasedDummy: UIView!
    @IBOutlet weak var releasedDateDummy: UIView!
    @IBOutlet weak var ratingStarDummy: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func shimmeringOn() {
        self.titleDummy.showAnimatedGradientSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
}
