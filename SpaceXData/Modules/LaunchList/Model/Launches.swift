//
//  Launches.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

protocol LaunchRepresentable {
    var name: String { get }
}

struct Launch: Codable {
    let id: String?
    let details: String?
    let name: String?
    let flight_number: Int?
    let launchDate: String?
    let success: Bool?
    let link: Link?
    let launchSite: LaunchSite?
    let rocket: Rocket?
    private enum CodingKeys : String, CodingKey {
        case id, details, name = "mission_name", flight_number, launchDate = "launch_date_utc", success = "launch_success", link = "links", launchSite = "launch_site", rocket
    }

}

struct Link: Codable {
    let wikipedia: String?
    
}

struct LaunchSite: Codable {
    let siteName: String?
    private enum CodingKeys : String, CodingKey {
        case siteName = "site_name"
    }
    
}



