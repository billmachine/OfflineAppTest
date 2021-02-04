//
//  DummyGame.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation

var dateFormatter = DateFormatter()

var dateDummy = { () -> Date? in
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: "2020-02-02")
}

//var gameDummies: [Game] = [
//    Game(
//        id: 3498
//        , image: #imageLiteral(resourceName: "gta")
//        , name: "Grand Theft Auto V"
//        , released:dateDummy()
//        , rating: 4.2
//    )
//]
