//
//  String + Extension.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

extension String {
    
    func yearStringFromDate() -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let date  = formatter.date(from: self)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = date else { return nil }
        return formatter.string(from: date)
    }
    
    func yearFromDate() -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let date  = formatter.date(from: self)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return date
        
    }
    
}


