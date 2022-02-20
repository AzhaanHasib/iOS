//
//  RocketDetailViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

class RocketDetailViewModel : NSObject {
    private var apiManager: LaunchesAPIManager?
    typealias rocketUpdateHandler = (Result<RocketDetailCellModel, Error>) -> Void
    var rocketViewModelCell : RocketDetailCellModel?
    
    // MARK: - Initialisation
    init(apiManager: LaunchesAPIManager) {
        self.apiManager = apiManager
        super.init()
    }
    
    func fetchRocketsDetail(_ rocketId:  String, completion:  @escaping rocketUpdateHandler)  {
        
        self.apiManager?.fetchRocketDeatil(params: rocketId, Rocket.self, completion: {[weak self] result  in
            DispatchQueue.main.async {
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let rocket):
                self?.rocketViewModelCell = self?.cellViewModel(rocket: rocket)
                completion(.success((self?.cellViewModel(rocket: rocket))!))
            }
          }
       })
     }
    
}

private extension RocketDetailViewModel {
    
    func cellViewModel(rocket: Rocket) -> RocketDetailCellModel {
        let rocketCellVMs : RocketDetailCellModel = RocketDetailCellModel(rocket)
        return rocketCellVMs
    }
        
}
