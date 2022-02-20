//
//  LaunchesCellViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

class LaunchesCellViewModel: NSObject, LaunchRepresentable {

    var name: String {
        launche.name ?? ""
    }
    
    var number: String {
        String(describing: launche.flight_number ?? 0)
    }
    
    var launchDateString: String {
        (launche.launchDate ?? "").yearStringFromDate()
    }
    
    var launchSuccess: Bool {
        launche.success ?? false
    }
    
    var launchDate: Date {
        (launche.launchDate ?? "").yearFromDate()
    }
    
    var rocketId: String? {
        launche.rocket?.id
    }
    
    var flightNumber: String? {
        String(describing: (launche.flight_number ?? 0 ))
    }
    
    var completeDetail: String {
        "Mission Name: \(launche.name ?? "")\n\n" + "Detail: \(launche.details ?? "")\n\n" + "Launch Date: \(launchDateString)\n\n" + "Launch Site: \(launche.launchSite?.siteName ?? "" )\n\n" + "Wikipedia: \(launche.link?.wikipedia ?? "")\n\n"
    }
    
    let launche: Launch
    
    init(_ launche: Launch) {
        self.launche = launche
    }
        
    
}
