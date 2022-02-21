//
//  RocketDetailCellModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

class RocketCellViewModel: NSObject, RocketRepresentable {

    var name: String {
        "RocketName: \(String(describing: rocket.name ?? ""))\n\n"
    }
    
    var descriptionDetail: String {
        "Detail: \(String(describing: rocket.description ?? ""))\n\n"
    }
    
    var country: String {
        "Country: \(String(describing: rocket.country ?? "") )\n\n"
    }
    
    var company: String {
        "Company: \(String(describing: rocket.company ?? ""))\n\n"
    }
    
    var wikipedia: String {
        "Wikipedia: \(String(describing: rocket.wikipedia ?? ""))\n\n"
    }
    
    var completeDetail: String {
        name + descriptionDetail + country + company + wikipedia
    }
    
    let rocket: Rocket
    
    init(_ rocket: Rocket) {
        self.rocket = rocket
    }
        
    
}
