//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ibraheem rawlinson on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    struct SearchPeopleData: Codable {
        let results: [UserInfo]
    }
    let gender: String
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    let name: Name
    struct Location: Codable {
        let city: String
        let state: String
    }
    let location: Location
    let email: String
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    let picture: Picture
}
