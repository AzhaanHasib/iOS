//
//  ParameterEncoding.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation
protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

struct URLEncoder: ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest
                
        guard let parameters = parameters else { return urlRequest }
        
        if urlRequest.httpMethod != nil {
            guard let url = urlRequest.url else {
                throw APIError.NetworkError.parameterEncodingFailed(message: "Missing Url")
            }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                urlComponents.queryItems = parameters.map { (key, value) -> URLQueryItem in
                    return URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                }
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        }
        return urlRequest
    }
}
