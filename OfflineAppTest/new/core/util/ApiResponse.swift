//
//  ApiResponse.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import Foundation

struct ApiResponse<Results:Codable>: Codable {

    let results: Results?
}
