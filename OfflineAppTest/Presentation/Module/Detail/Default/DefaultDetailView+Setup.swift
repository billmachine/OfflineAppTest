//
//  DefaultDetailView+Setup.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 30/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

extension DefaultDetailView {
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        }
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    func setupCollection() {
        genreCollection.register(UINib(nibName:
                                        GenreCollectionViewCell.identifier, bundle: nil),
                                 forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        ssCollection.register(UINib(nibName:
                                        SSCollectionViewCell.identifier, bundle: nil),
                              forCellWithReuseIdentifier: SSCollectionViewCell.identifier)
        
        let alignedFlowLayout = genreCollectionFlowLayout as? AlignedCollectionViewFlowLayout
        alignedFlowLayout?.horizontalAlignment = .left
        alignedFlowLayout?.verticalAlignment = .top
   }
    
    @objc func visitTapped(_ sender: RoundButton) {
        presenter?.didVisit()
    }
    
    @IBAction func addFavoriteTap(_ gesture: UITapGestureRecognizer) {
        presenter?.didAddFavorite()
    }
    
    func setupAction() {
        btnKunjungi.addTarget(self, action: #selector(self.visitTapped(_:)), for: .touchUpInside)
        btnTambahkan.addGestureRecognizer(UITapGestureRecognizer(
                                            target: self, action:Selector(("addFavoriteTap:"))))
    }
    
    func setupView() {
        btnKunjungi.layer.borderColor = UIColor.red.cgColor
    }
    
    func presentError() {
        let alert = UIAlertController(title: "Oops error ", message: "Game Sudah Ada", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if let topController = UIApplication.topViewController() {
            guard topController == self else { return }
            self.present(alert, animated: true)
        }
    }
    
    func presentSuccess() {
        let alert = UIAlertController(title: "Sukses ", message: "Game Berhasil Ditambahkan", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if let topController = UIApplication.topViewController() {
            guard topController == self else { return }
            self.present(alert, animated: true)
        }
    }
}
