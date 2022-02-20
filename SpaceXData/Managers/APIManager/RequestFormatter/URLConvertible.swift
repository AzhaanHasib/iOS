//
//  URLConvertible.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self)
            else { throw APIError.NetworkError.invalidUrl(message: "Invalid URL string") }
        debugPrint(url)
        return url
    }
    
}
