//
//  APIError.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

/// Errors enum, to be sent back to network caller, so he handle it gracefully.

public enum APIError: Error {
    public enum NetworkError: Error {
        case invalidUrl(message: String)
        case parameterEncodingFailed(message: String)
        case noNetwork(message: String)
    }
}
