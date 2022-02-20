//
//  Rocket.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

protocol RocketRepresentable {
    var name: String { get }
}

struct Rocket: Codable {
    let id: String?
    let country: String?
    let company: String?
    let wikipedia: String?
    let name: String?
    let description: String?
    
    private enum CodingKeys : String, CodingKey {
        case  id = "rocket_id", country, company, wikipedia , name = "rocket_name", description
    }

}
