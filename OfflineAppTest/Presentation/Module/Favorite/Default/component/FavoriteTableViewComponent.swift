//
//  FavoriteTableViewComponent.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 31/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import MaterialComponents

class FavoriteListTableComponentView : UIView {

    public let tableView = UITableView()
    let screenSize: CGRect = UIScreen.main.bounds
    let mdCard = MDCCard()
    
    let controller:DefaultFavoriteView
    
    lazy var bannerView: UIView = {
        let banner = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: floor(screenSize.height*35/100)))
        banner.backgroundColor = Colors.colorPrimary
        return banner
    }()
    
    lazy var cardView: UIView = {
        let bottomHeight = (controller.tabBarController?.tabBar.frame.height ?? 69.0)
        +(controller.navigationController?.navigationBar.frame.height ?? 44.0) + 40
        let card = MDCCard(frame: CGRect(x: 10, y: 0, width: screenSize.width - 20, height: screenSize.height - bottomHeight))
        return card
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Favorites"
        title.textColor = Colors.colorPrimary
        title.font = UIFont.boldSystemFont(ofSize: 12.0)

        return title
    }()
    
    lazy var placeHolderView: UIView = {
        var placeHolderView = (Bundle.main.loadNibNamed("PlaceHolderView", owner: self, options: nil)![0]) as! UIView
        placeHolderView.translatesAutoresizingMaskIntoConstraints = false
        return placeHolderView
    }()

    var safeArea: UILayoutGuide!

    // MARK: Init Function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(controller: DefaultFavoriteView
    ) {
        self.controller = controller
        super.init(frame: UIScreen.main.fixedCoordinateSpace.bounds)
        self.addSubviews()
    }

    private func addSubviews() {
        safeArea = layoutMarginsGuide
        
        self.addSubview(bannerView)
        
        self.addSubview(cardView)
        
        cardView.addSubview(titleLabel)
        setupTitle()
        
        cardView.addSubview(placeHolderView)
        setupPlaceHolderView()
        
        cardView.addSubview(tableView)
        setupTable()
        
    }

}

extension FavoriteListTableComponentView {
    func setupTable() {
        tableView.register(UINib(nibName: FavoritesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: cardView.leftAnchor,constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,constant: -20).isActive = true
        tableView.rightAnchor.constraint(equalTo: cardView.rightAnchor,constant: -5).isActive = true
        tableView.separatorStyle = .none
    }
    
    func setupTitle() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
    }
    
    func setupPlaceHolderView() {
        placeHolderView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        placeHolderView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
    }
}
