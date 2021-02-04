//
//  ListView.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension DefaultListView: ListView {
    func showList() {}
    func showError() {}
    func showLoading() {}
    func hideLoading() {}
}

class DefaultListView: UIViewController {
    
    var presenter: ListPresenter?
    
    @IBOutlet weak var gameTable: UITableView!
    @IBOutlet weak var stackPlaceholder: UIStackView!
    @IBOutlet weak var labelPlaceholder: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear()
        setupNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTable()
        
        _ = presenter?.displayedGames
            .observeOn(MainScheduler.instance)
            .bind(to: gameTable.rx.items) { tableView,row,game -> UITableViewCell in
                let indexPath = IndexPath.init(row: row, section: 0)
                if game.state == .loading {
                    guard let cell = tableView.dequeueReusableCell(
                            withIdentifier: DummyTableViewCell.identifier, for: indexPath) as? DummyTableViewCell
                    else { return UITableViewCell()}
                    cell.shimmeringOn()
                    return cell
                } else {
                    guard let cellgameTvc = tableView.dequeueReusableCell(
                            withIdentifier: GameTableViewCell.identifier, for: indexPath) as? GameTableViewCell
                    else { return UITableViewCell()}
                    cellgameTvc.fill(game: game)
                    return cellgameTvc
                }
            }
        
        _ = Observable
            .zip(gameTable.rx.itemSelected, gameTable.rx.modelSelected(GameDomain.self))
            .bind {  indexPath, model in
                self.presenter?.didSelect(model)
            }
        
        _ = gameTable.rx.contentOffset.subscribe {
            let currentOffset = $0.element?.y
            let maxOffset = self.gameTable.contentSize.height - self.gameTable.bounds.height
                + self.gameTable.contentInset.bottom + self.gameTable.contentInset.top
            if currentOffset == maxOffset {
                self.presenter?.loadMore()
            }
        }
        
        _ = presenter?.displayedState.subscribe { state in
            if let state = state.element {
                if state == .home {
                    DispatchQueue.main.async {
                        self.gameTable.isHidden = false
                    }
                }
            }
        }
        
        _ = searchController.searchBar.rx.text
            .skip(1)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {  searchText in
                if let word = searchText {
                    if !word.isEmpty {
                        self.presenter?.didSearch(word)
                    }
                }
            })
        
        _ = presenter?.searchState.subscribe { state in
            if self.presenter?.displayedState.value != .search { return }
            
            DispatchQueue.main.async {
                if let state = state.element {
                    switch state {
                    case .loading:
                        self.gameTable.isHidden = false
                        self.searchController.searchBar.isLoading = true
                    case .idle:
                        self.gameTable.isHidden = true
                        self.searchController.searchBar.isLoading = false
                    case .success:
                        self.gameTable.isHidden = false
                        self.searchController.searchBar.isLoading = false
                    case .empty:
                        self.gameTable.isHidden = true
                        self.searchController.searchBar.isLoading = false
                        self.labelPlaceholder.text = "Data Tidak Ditemukan"
                    case .error:
                        self.gameTable.isHidden = true
                        self.searchController.searchBar.isLoading = false
                        self.labelPlaceholder.text = "Terjadi Error"
                    }
                }
            }
        }
  
    }
    
}

extension DefaultListView:UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.switchState(state: .search)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.switchState(state: .home)
    }
}
