//
//  HTTPMethods.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String:String]
