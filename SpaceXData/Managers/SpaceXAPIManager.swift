//
//  LaunchesAPIManager.swift
//
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

public enum APIResponseStatus<String> {
    case success
    case failure(string: String?)
}

class LaunchesAPIManager: NetworkManager<LaunchesAPIPathConfigurator> {
    
    func fetchLaunches<T:Decodable>(params: Parameters,_ modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(route: LaunchesAPIPathConfigurator.getLaunches(params)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let responseStatus = self.handleNetworkResponse(response)
                switch responseStatus {
                    case .failure(let error):
                        completion(.failure(error!))// need to check
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(NetworkResponse.noData))
                            return
                        }
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(T.self, from: responseData)
                            completion(.success(responseModel))

                        } catch {
                            completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NetworkResponse.noResponse))
            }
        }
     }
    
    func fetchLaunchesDeatil<T: Decodable>(params: String, _ modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(route: LaunchesAPIPathConfigurator.getLaunchesDetail(params)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let responseStatus = self.handleNetworkResponse(response)
                switch responseStatus {
                    case .failure(let error):
                        completion(.failure(error!))// need to check
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(NetworkResponse.noData))
                            return
                        }
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(T.self, from: responseData)
                            completion(.success(responseModel))
                        } catch {
                            completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NetworkResponse.noResponse))
            }
        }
     }
    
    func fetchRocketDeatil<T: Decodable>(params: String, _ modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(route: LaunchesAPIPathConfigurator.getRocketDetail(params)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let responseStatus = self.handleNetworkResponse(response)
                switch responseStatus {
                    case .failure(let error):
                        completion(.failure(error!))// need to check
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(NetworkResponse.noData))
                            return
                        }
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(T.self, from: responseData)
                            completion(.success(responseModel))
                        } catch {
                            completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NetworkResponse.noResponse))
            }
        }
     }
    
    enum NetworkResponse:String, Error {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
        case noResponse = "Url response could not be parsed."
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> APIResponseStatus<Error>{
        switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(string: NetworkResponse.authenticationError)
            case 501...599: return .failure(string: NetworkResponse.badRequest)
            case 600: return .failure(string: NetworkResponse.outdated)
            default: return .failure(string: NetworkResponse.failed)
        }
    }
}



 
