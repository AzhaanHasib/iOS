//
//  LaunchDetailViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import Foundation

class LaunchDetailViewModel : NSObject {
    private var apiManager: LaunchesAPIManager?
    typealias launchUpdateHandler = (Result<LaunchesCellViewModel, Error>) -> Void
    var launchCellViewModel : LaunchesCellViewModel?
    
    // MARK: - Initialisation
    init(apiManager: LaunchesAPIManager) {
        self.apiManager = apiManager
        super.init()
    }
    
    func fetchLaunchesDetail(_ flightNumber:  String, completion:  @escaping launchUpdateHandler)  {
        
        self.apiManager?.fetchLaunchesDeatil(params: flightNumber, Launch.self, completion: {[weak self] result  in
            DispatchQueue.main.async {
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let launche):
                self?.launchCellViewModel = self?.cellViewModel(launch: launche)
                completion(.success((self?.cellViewModel(launch: launche))!))
            }
          }
       })
     }
    
}

private extension LaunchDetailViewModel {
    
    func cellViewModel(launch: Launch) -> LaunchesCellViewModel {
        let launchCellVMs : LaunchesCellViewModel = LaunchesCellViewModel(launch)
        return launchCellVMs
    }
        
}
