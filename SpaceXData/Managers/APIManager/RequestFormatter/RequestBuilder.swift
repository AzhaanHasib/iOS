//
//  APIRequestBuilder.swift
//
//  Created by Created by Azhaan Hasib on 18/02/22.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

protocol RequestBuilder: Request {
    var mainURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var method: HTTPMethods { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
    
}

extension RequestBuilder {
    
   internal var mainURL: String {

    debugPrint(AppEnvironment.ServerType.uat.mainUrl)
        return AppEnvironment.ServerType.uat.mainUrl
    }
    
    var method: HTTPMethods {
        return .get
    }
    
   internal var headers: HTTPHeaders {
     return ["Content-Type": "application/json"]
    }
    
   internal var encoding: ParameterEncoding {
        return URLEncoder()
    }
    
    var urlRequest: URLRequest {
        let url = try? mainURL.asURL()
        debugPrint(url)
        var request = URLRequest(url: (url?.appendingPathComponent(self.path))!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 60.0
        request.httpMethod = method.rawValue
        
        // HTTP Header fields
        request.allHTTPHeaderFields = headers
        
        do {
            request = try encoding.encode(request, with: parameters)
        } catch {
            //debugPrint(error)
        }
        return request
    }
}
