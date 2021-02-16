//
//  DefaultFavoriteView.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 31/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import RxSwift
import GamePackage

class DefaultFavoriteView : UIViewController {
    lazy var _view: FavoriteListTableComponentView = {
        return FavoriteListTableComponentView(controller: self)
    }()
    
    public init(presenter:FavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var presenter: FavoritePresenter?
    
    override func viewDidLoad() {
        self.view = _view
        
        _ = presenter?.displayedGames.subscribe(onNext : { result in
            if !result.isEmpty {
                self._view.tableView.isHidden = false
            } else {
                self._view.tableView.isHidden = true
            }
        })
        
        _ = presenter?.displayedGames
            .observeOn(MainScheduler.instance)
            .bind(to: _view.tableView.rx.items) { tableView,row,favorite -> UITableViewCell in
                
                guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: FavoritesTableViewCell.identifier, for: IndexPath.init(row: row,  section: 0)) as? FavoritesTableViewCell
                else { return UITableViewCell() }
                
                cell.fill(favorite: favorite)
                cell.actionDelete = {
                    let alert = UIAlertController(
                        title: "Peringatan",
                        message: "Hapus \(favorite.name) dari favorit ?",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "Iya,hapus", style: .default) { (_) in
                        DispatchQueue.main.async {
                            self.presenter?.didDelete(favorite)
                        }
                    })
                    
                    alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
               
                return cell
            }
        
        _ = _view.tableView
            .rx
            .modelSelected(GameDomain.self)
            .subscribe(onNext: { (model) in
                self.presenter?.didSelect(model)
            })

        _ = _view.tableView.rx.itemSelected
          .subscribe(onNext: {  _ in
            
          })
        
        _ = _view.tableView.rx.setDelegate(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
        setupNavbar()
    }
    
}

extension DefaultFavoriteView : FavoriteView {
    
}
extension DefaultFavoriteView: UITableViewDelegate {
}
