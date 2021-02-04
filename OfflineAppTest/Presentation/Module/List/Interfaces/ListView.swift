//
//  ListView.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 04/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//
protocol ListView: class {
    
    var presenter: ListPresenter? { get set }
    
    func showList()
    
    func showError()
    
    func showLoading()
    
    func hideLoading()

}
