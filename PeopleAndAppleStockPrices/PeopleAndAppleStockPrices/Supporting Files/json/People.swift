//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ibraheem rawlinson on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct People: Codable {
    struct SearchPeopleData: Codable {
        let results: [People]
    }
    struct SearchNameData: Codable {
        let name: [SearchNameData]
    }
    struct SearchLocationData: Codable {
        let location: [SearchNameData]
    }
    struct SearchPictureData: Codable {
        let picture: [SearchNameData]
    }
    let first: String
    let last: String
    let city: String
    let state: String
    let email: String
    let large: String
    let thumbnail: String
}
