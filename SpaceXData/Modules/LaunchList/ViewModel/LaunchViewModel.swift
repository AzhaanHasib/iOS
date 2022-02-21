//
//  LaunchViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation

protocol LaunchViewModelType {
    
    typealias launchUpdateHandler = (Result<[LaunchCellViewModel], Error>) -> Void
    func fetchLaunches(completion: @escaping launchUpdateHandler)
    func cellViewModels(launchList: [Launch]) -> [LaunchCellViewModel]
    func getRequestParams() -> [String : Any]
    func filterAndSortLaunches(_ sortType: SortType )
    func sortOnName()
    func sortOnDate()
    func getCellViewModels() ->  [LaunchCellViewModel]?
}


class LaunchViewModel: LaunchViewModelType {
    private var apiManager: LaunchesAPIManager?
    var launchCellViewModels : [LaunchCellViewModel]?
    
    
    // MARK: - Initialisation
    init(apiManager: LaunchesAPIManager) {
        self.apiManager = apiManager
    }
    
    func fetchLaunches(completion: @escaping launchUpdateHandler)  {
        let params = getRequestParams()
        
        self.apiManager?.fetchLaunches(params: params, [Launch].self, completion: {[weak self] result  in
            DispatchQueue.main.async {
            guard let self = self else { return }
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let launches):
                if self.launchCellViewModels != nil {
                    self.launchCellViewModels?.append(contentsOf: self.cellViewModels(launchList: launches) )
                }
                else {
                    self.launchCellViewModels = self.cellViewModels(launchList: launches)
                }
                completion(.success((self.cellViewModels(launchList: launches))))
            }
          }
       })
     }
}

extension LaunchViewModel {
    
    func getRequestParams() -> [String : Any] {
        return [ "limit": 10,
                 "offset" : launchCellViewModels?.count ?? 0
        ]
    }
    func cellViewModels(launchList: [Launch]) -> [LaunchCellViewModel] {
        launchList.map {LaunchCellViewModel($0) }
    }
    
    func getCellViewModels() -> [LaunchCellViewModel]? {
        return launchCellViewModels
    }
        
}

 extension LaunchViewModel {
    
     func filterAndSortLaunches(_ sortType: SortType = .none) {
         switch sortType {
         case .byDate:
               sortOnDate()
         case .byName:
               sortOnName()
         case .none:break
         }
     }
     
     func sortOnName() {
         launchCellViewModels = launchCellViewModels?.sorted(by: { lhs, rhs in
             ((lhs.launch.name ?? "").localizedCaseInsensitiveCompare(rhs.launch.name ?? "") == .orderedAscending)
         })
     }
     
     func sortOnDate() {
         launchCellViewModels = launchCellViewModels?.sorted(by: { lhs, rhs in
              ((lhs.launchDate ?? Date()) > (rhs.launchDate ?? Date()))
         })
     }
    
}

enum SortType: String {
    case byDate = "Sort by Launch Date"
    case byName = "Sort by Mission name"
    case none   = "None"
    
}
