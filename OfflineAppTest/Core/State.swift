//
//  State.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation
import UIKit

enum DownloadState {
    case idle,loading,error,empty,success
}

enum ListPageState {
    case search,home
}
