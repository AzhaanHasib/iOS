//
//  LaunchViewModel.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import Foundation


class LaunchViewModel : NSObject {
    private var apiManager: LaunchesAPIManager?
    typealias launchUpdateHandler = (Result<[LaunchesCellViewModel], Error>) -> Void
    var launcheCellViewModel : [LaunchesCellViewModel]?
    
    // MARK: - Initialisation
    init(apiManager: LaunchesAPIManager) {
        self.apiManager = apiManager
        super.init()
    }
    
    func fetchLaunches(completion: @escaping launchUpdateHandler)  {
        let params = getRequestParams()
        
        self.apiManager?.fetchLaunches(params: params, [Launch].self, completion: {[weak self] result  in
            DispatchQueue.main.async {
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let launches):
                if self?.launcheCellViewModel != nil {
                    self?.launcheCellViewModel?.append(contentsOf: self?.cellViewModel(launchList: launches) ?? [])
                }
                else {
                    self?.launcheCellViewModel = self?.cellViewModel(launchList: launches)
                }
                completion(.success((self?.cellViewModel(launchList: launches))!))
            }
          }
       })
     }
    
}

private extension LaunchViewModel {
    
    func getRequestParams() -> [String : Any] {
        return [ "limit"
                 : 10, "offset" : launcheCellViewModel?.count ?? 0
        ]
    }
    func cellViewModel(launchList: [Launch]) -> [LaunchesCellViewModel] {
        var launchCellVMs : [LaunchesCellViewModel] = []
        launchCellVMs = launchList.map {LaunchesCellViewModel($0) }
        return launchCellVMs
    }
        
}

 extension LaunchViewModel {
    
     func filterAndSortLaunches(_ sortType: SortType = .none, _ isFilterOn: Bool = false) {
         
         switch sortType {
         case .byDate:
               sortOnDate()
         case .byName:
               sortOnName()
         case .none:break
         }
         if isFilterOn {
             filterBySuccess()
         }
     }
     
     func sortOnName() {
         let list = launcheCellViewModel?.sorted(by: { obj1, obj2 in
             let fName = obj1.name
             let sName = obj2.name
             return (fName.localizedCaseInsensitiveCompare(sName) == .orderedAscending)

         })
        launcheCellViewModel = list
     }
     
     func sortOnDate() {
         let list = launcheCellViewModel?.sorted(by: { obj1, obj2 in
             let fDate = obj1.launchDate
             let sDate = obj2.launchDate
             return (fDate > sDate)

         })
         launcheCellViewModel = list
         
     }
     
     func filterBySuccess(_ isFilterOn: Bool = false) {
         if isFilterOn {
             let list = launcheCellViewModel?.filter({ obj in
                 return obj.launchSuccess == true
             })
             launcheCellViewModel = list
         }
         
     }
    
}

enum SortType: String {
    case byDate = "Sort by Launch Date"
    case byName = "Sort by Mission name"
    case none   = "None"
    
}
