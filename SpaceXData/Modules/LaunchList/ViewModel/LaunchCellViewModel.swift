//
//  LaunchesCellViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

class LaunchCellViewModel: NSObject, LaunchRepresentable {

    var number: String {
        String(describing: launch.flight_number ?? 0)
    }
    var launchDateString: String? {
        (launch.launchDate ?? "").yearStringFromDate()
    }
    var launchSuccess: Bool {
        launch.success ?? false
    }
    var launchDate: Date? {
        (launch.launchDate ?? "").yearFromDate()
    }
    var rocketId: String? {
        launch.rocket?.id
    }
    var flightNumber: String? {
        String(describing: (launch.flight_number ?? 0 ))
    }
    var details: String {
        "Detail: \(String(describing: launch.details ?? ""))\n\n"
    }
    var siteName: String {
        "Launch Site: \(String(describing: launch.launchSite?.siteName ?? "") )\n\n"
    }
    var wikipedia: String {
        "Wikipedia: \(String(describing: launch.link?.wikipedia ?? "") )\n\n"
    }
    var name: String {
        " Mission Name: \(String(describing: launch.name ?? ""))\n\n"
    }
    var launchDateStringDetail: String {
        "Launch Date: \(String(describing: launchDateString ?? ""))\n\n"
    }
    var successDetail: String {
        " Launch Success: \(launchSuccess ? "True" : "False")\n"
    }
    
    var completeLaunchDetail: String {
        name + details + launchDateStringDetail + siteName + wikipedia
    }
    
    var minimalLaunchDetail: String {
        name + launchDateStringDetail + successDetail
    }
    
    let launch: Launch
    
    init(_ launch: Launch) {
        self.launch = launch
    }
        
    
}
