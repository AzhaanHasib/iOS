//
//  AppEnvironment.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

enum AppEnvironment {
    
    enum ServerType {
        case development
        case uat
        case production
        
        var mainUrl: String {
            debugPrint("\(urlProtocol)://\(domain)\(route)")
            return "\(urlProtocol)://\(domain)\(route)"
        }
        
        var urlProtocol: String {
            switch self {
                case .uat:
                    return "https"
                default:
                    return "http"
            }
        }
        
        var domain: String {
            switch self {
                case .development, .uat, .production:
                    return "api.spacexdata.com"
            }
        }
    
        var route: String {
            "/v3"
        }
    }
}
