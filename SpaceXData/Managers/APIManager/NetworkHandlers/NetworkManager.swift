//
//  APIManager.swift
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

typealias APIRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol APIRouter: class {
    associatedtype APIRoute: RequestBuilder
    
    func performRequest(route: APIRoute, completion: @escaping APIRouterCompletion)
    func cancel()
}

class NetworkManager<APIRoute: RequestBuilder>: APIRouter {
    private var task: URLSessionDataTask?
    
    func performRequest(route service: APIRoute, completion: @escaping APIRouterCompletion) {
        let urlSession = URLSession.shared
        self.task = urlSession.dataTask(with: service.urlRequest, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
