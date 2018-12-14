//
//  String+extensions.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ibraheem rawlinson on 12/14/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
extension String {
    public func stripHTML() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    static func formattedDate(srt: String) -> String {
        var formattedString = srt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: srt) {
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            formattedString = dateFormatter.string(from: date)
        } else {
            print("formattedDate: invalid date")
        }
        return formattedString
    }
}
