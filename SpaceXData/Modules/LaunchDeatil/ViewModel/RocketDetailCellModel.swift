//
//  RocketDetailCellModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

class RocketDetailCellModel: NSObject, RocketRepresentable {

    var name: String {
        rocket.name ?? ""
    }
    
    var completeDetail: String {
        
        "RocketName: \(rocket.name ?? "")\n\n" + "Detail: \(rocket.description ?? "")\n\n" + "Country: \(rocket.country ?? "")\n\n" + "Company: \(rocket.company ?? "" )\n\n" + "Wikipedia: \(rocket.wikipedia ?? "")\n\n"
    }
    
    
    let rocket: Rocket
    
    init(_ rocket: Rocket) {
        self.rocket = rocket
    }
        
    
}
