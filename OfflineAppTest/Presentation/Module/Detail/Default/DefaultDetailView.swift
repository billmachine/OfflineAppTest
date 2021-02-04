//
//  DefaultDetailView.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 06/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Cosmos
import SDWebImage
import SVProgressHUD

extension DefaultDetailView : DetailView {
}

class DefaultDetailView: UIViewController {

    var presenter: DetailPresenter?
    
    @IBOutlet weak var ssCollection: UICollectionView!
    
    @IBOutlet weak var genreCollection: UICollectionView!
    @IBOutlet weak var genreCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var btnKunjungi: RoundButton!
    @IBOutlet weak var btnTambahkan: RoundButton!
    
    @IBOutlet weak var txtRating: UILabel!
    @IBOutlet weak var txtRatingTop: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var txtRatingCount: UILabel!
    @IBOutlet weak var txtReleased: UILabel!
    @IBOutlet weak var gameImg: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollection()
        setupAction()
        setupView()
        
        self.gameImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        _ = presenter?.displayedDetailGame
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                if let game = result.element {
                    self.fill(game: game)
                }
            }
        
        _ = presenter?.loadState.subscribe(onNext: { state in
            if state == .error {
                SVProgressHUD.dismiss()
                self.navigationController?.popViewController(animated: true) }
            if state == .loading {
                SVProgressHUD.setDefaultMaskType(.black)
                SVProgressHUD.show(withStatus: "Loading ... ")
            }
            if state == .success {
                SVProgressHUD.dismiss()
            }
        })
        
        _ = presenter?.addFavoriteState.subscribe(
            onNext: { result in
                if result == .success {
                self.presentSuccess()
                }
                if result == .error {
                self.presentError()
                }
            },
            onError: { _ in
                self.presentError()
            }
            )
        
        _ = presenter?.displayedScreenShots
            .observeOn(MainScheduler.instance)
            .bind(to: ssCollection.rx.items) { colectionView,row,ss -> UICollectionViewCell in
                let indexPath = IndexPath.init(row: row, section: 0)
                
                guard let cell = colectionView.dequeueReusableCell(
                        withReuseIdentifier: SSCollectionViewCell.identifier, for: indexPath) as? SSCollectionViewCell
                
                else { return UICollectionViewCell()}
                
                cell.ssImage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.ssImage.image = UIImage(named: "ic_placeholder")
                SDWebImageManager.shared.loadImage(
                    with: ss.image,
                    options: .highPriority,
                    progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                    cell.ssImage.image = image
                    cell.ssImage.sd_imageIndicator = nil
                    cell.ssImage.sd_imageIndicator = .none
                }
                
                return cell
            }

        _ = presenter?.displayedGenres
            .observeOn(MainScheduler.instance)
            .bind(to: genreCollection.rx.items) { colectionView,row,genre -> UICollectionViewCell in
                let indexPath = IndexPath.init(row: row, section: 0)
                
                guard let cell = colectionView.dequeueReusableCell(
                        withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell
                
                else { return UICollectionViewCell()}
                
                cell.txtGenre.text = genre.name ?? ""
                return cell
            }
    }
    
}

extension DefaultDetailView {
    
    func fill(game:GameDomain?) {
        self.navigationItem.title = game?.name
       
        self.gameImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        self.gameImg.image = UIImage(named: "ic_placeholder")
        _ = SDWebImageManager.shared.loadImage(
            with: game?.bg_image,
            options: .continueInBackground, // or .highPriority
            progress: nil,
            completed: { [weak self] (image, data, error, cacheType, finished, url) in
                guard self != nil else { return }
                self?.gameImg.sd_imageIndicator = nil
                self?.gameImg.sd_imageIndicator = .none
                if error != nil {
                    // Do something with the error
                    return
                }
                guard image != nil else {
                    // No image handle this error
                    return
                }
                // Do something with image
                self?.gameImg.image = image
            }
        )

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        var date = ""
        if let dateNil = game?.released {
            date = dateFormatter.string(from: dateNil)
        }
        self.txtReleased.text = date
        
        self.txtRating.text = String(describing:game?.rating ?? 0)
        
        let ratingTopRound = ceil(game?.rating ?? 0.0)
        let ratingTopRoundStr = String(format: "%.2f", ratingTopRound)
        self.txtRatingTop.text = "\((ratingTopRoundStr))"
        
        self.starRating.settings.totalStars = Int(ratingTopRound)
        self.starRating.settings.fillMode = .precise
        self.starRating.settings.updateOnTouch = false
        self.starRating.rating = game?.rating ?? 0
        
        self.txtRatingCount.text = "\(game?.reviews_count ?? 0)" + " Review"
    }
}
    
