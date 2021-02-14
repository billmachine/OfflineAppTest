//
//  DefaultView+Setup.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 22/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit

extension DefaultListView {
    
    func setupSearchBar() {
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    func setupNavbar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            
            navBarAppearance.backgroundColor = .white
            navBarAppearance.shadowColor = .clear
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.overrideUserInterfaceStyle = .light
            
            setNeedsStatusBarAppearanceUpdate()
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
            
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.tintColor = .systemBlue
        
        navigationController?.navigationBar.topItem?.title = Strings.app
        
        let navbarIcon = UIImageView()
        navbarIcon.contentMode = .scaleAspectFit
        let imgLogo = UIImage(named: "controller.png")
        navbarIcon.image = imgLogo
        navigationItem.titleView = navbarIcon
        
        let button = UIBarButtonItem(image: UIImage(named: "ic_profile")?.withRenderingMode(.alwaysOriginal),
                                     style: .plain,
                                     target:self,
                                     action:#selector(barBtnClick))
        let buttonDummy = UIBarButtonItem(image: UIImage(named: "ic_profile"),
                                          style: .plain,
                                          target:self,
                                          action:#selector(barBtnClick))
        buttonDummy.tintColor = UIColor.red.withAlphaComponent(0)
        
        navigationItem.leftBarButtonItem = buttonDummy
        navigationItem.rightBarButtonItem = button
        
    }
    
     func setupTable() {
        gameTable.register(UINib(nibName: GameTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier)
        gameTable.register(UINib(nibName: DummyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DummyTableViewCell.identifier)
        
        gameTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshSwipped(_:)), for: .valueChanged)

    }
    
    @objc func barBtnClick(_ sender: Any) {
        let destroyAction = UIAlertAction(title:"Iya",style: .destructive) { (_) in
            exit(1)
        }
        let cancelAction = UIAlertAction(title:"Batal",style: .cancel) { (_) in }
        let alertLogout = UIAlertController(title:"Konfirmasi Logout" ,
                                            message: "Keluar Dari Aplikasi ?" ,
                                            preferredStyle: .actionSheet)
        alertLogout.addAction(destroyAction)
        alertLogout.addAction(cancelAction)
        if let topController = UIApplication.topViewController() {
            guard topController == self else { return }
            self.present(alertLogout, animated: true) {}
        }
    }
 
    @objc func refreshSwipped(_ sender: Any) {
        presenter?.reload()
        refreshControl.endRefreshing()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
//    }
    
}
