//
//  LaunchesAPIPathConfigurator.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

enum LaunchesAPIPathConfigurator {
    case getLaunches(_ param: Parameters)
    case getLaunchesDetail(_ flightnumber: String)
    case getRocketDetail(_ ricketid: String)
}

extension LaunchesAPIPathConfigurator: RequestBuilder {
    var parameters: Parameters? {
        var queryParams: Parameters?
        switch self {
            case .getLaunches(let params):
                queryParams = params
        case .getLaunchesDetail,.getRocketDetail:
              break
        }
        return queryParams
    }
    
    var path: String {
        switch self {
            case .getLaunches:
            return ServerPaths.publiclaunches.rawValue
        case.getLaunchesDetail(let flightNumber):
            return ServerPaths.publiclaunches.rawValue +  "/" + flightNumber
        case .getRocketDetail(let rocketid):
            return ServerPaths.rocket.rawValue +  "/" + rocketid
        }
    }
    
    var paramEncoder: ParameterEncoding {
        switch self {
            case .getLaunches:
                return URLEncoder()
        case .getLaunchesDetail(_),.getRocketDetail(_):
            return URLEncoder()
        }
    }
}

extension LaunchesAPIPathConfigurator: ResponseHandler {
    typealias ResponseDataType = [Launch]
    
    static func parseResponse(data: Data) throws -> ResponseDataType {
        do {
            return try JSONDecoder().decode(ResponseDataType.self, from: data)
        } catch {
            throw error
        }
    }

}

