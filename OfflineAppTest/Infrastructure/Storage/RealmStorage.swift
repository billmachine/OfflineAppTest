//
//  RealmStorage.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 11/01/21.
//  Copyright © 2021 nostratech. All rights reserved.
//

import Foundation
import RealmSwift

public final class RealmStorage {
    let realm: Realm?
    
    private init() {
            self.realm = try? Realm(queue: .main)
    }
    
    static let sharedInstance:  RealmStorage = RealmStorage()
    
}
