//
//  ResponseHandler.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation
protocol ResponseHandler {
    associatedtype ResponseDataType
    
    static func parseResponse(data: Data) throws -> ResponseDataType
}
