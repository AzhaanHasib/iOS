//
//  LaunchDetailViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

enum CustomError: String, Error {
    
    case notaValidObject
}

protocol LaunchDetailViewModelType {
    func fetchLaunchesDetail(_ flightNumber:  String, completion:  @escaping launchUpdateHandler)
    typealias launchUpdateHandler = (Result<LaunchCellViewModel, Error>) -> Void
    typealias rocketUpdateHandler = (Result<RocketCellViewModel, Error>) -> Void
    func fetchRocketsDetail(_ rocketId:  String, completion:  @escaping rocketUpdateHandler)
    func getCellLaunchViewModel() -> LaunchCellViewModel?
    func getCellRocketViewModel() -> RocketCellViewModel?
    func getNumberOfRows() -> Int
}

class LaunchDetailViewModel : LaunchDetailViewModelType {
    private var apiManager: LaunchesAPIManager?
    var rocketViewModelCell : RocketCellViewModel?
    var launchCellViewModel : LaunchCellViewModel?
    
    // MARK: - Initialisation
    init(apiManager: LaunchesAPIManager) {
        self.apiManager = apiManager
    }
    
    func fetchLaunchesDetail(_ flightNumber:  String, completion:  @escaping launchUpdateHandler)  {
        self.apiManager?.fetchLaunchesDeatil(params: flightNumber, Launch.self, completion: {[weak self] result  in
            guard let self = self else { return  }
            DispatchQueue.main.async {
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let launch):
                self.launchCellViewModel = LaunchCellViewModel(launch)
                guard let launchCellViewModel = self.launchCellViewModel else {
                   return  completion(.failure(CustomError.notaValidObject))
                }
                completion(.success((launchCellViewModel)))
            }
          }
       })
     }
    
    func fetchRocketsDetail(_ rocketId:  String, completion:  @escaping rocketUpdateHandler)  {
        self.apiManager?.fetchRocketDeatil(params: rocketId, Rocket.self, completion: {[weak self] result  in
            guard let self = self else { return  }
            DispatchQueue.main.async {
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let rocket):
                self.rocketViewModelCell = RocketCellViewModel(rocket)
                guard let rocketViewModelCell = self.rocketViewModelCell else {
                    return  completion(.failure(CustomError.notaValidObject))
                }
                completion(.success((rocketViewModelCell)))
            }
          }
       })
     }
}

extension LaunchDetailViewModel {
  
  func getCellLaunchViewModel() -> LaunchCellViewModel? {
      launchCellViewModel
  }
  
  func getCellRocketViewModel() -> RocketCellViewModel? {
      rocketViewModelCell
  }
    
  func getNumberOfRows() -> Int {
     (getCellLaunchViewModel() == nil && getCellRocketViewModel() == nil ) ? 0 : (getCellRocketViewModel() == nil ? 1 : 2)
  }
      
}
