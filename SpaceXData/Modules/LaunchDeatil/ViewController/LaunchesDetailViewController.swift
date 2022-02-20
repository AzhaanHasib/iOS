//
//  LaunchesDetailViewController.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import UIKit

class LaunchesDetailViewController: UIViewController {
    
    // MARK: - Properties -
    private let launchViewModel = LaunchDetailViewModel(apiManager: LaunchesAPIManager())
    private let rocketViewModel = RocketDetailViewModel(apiManager: LaunchesAPIManager())

    var flightNumber: String?
    var rocketId: String?
    
    lazy private var detailTableView: UITableView = {
         let tv = UITableView(frame: .zero, style: .plain)
         tv.translatesAutoresizingMaskIntoConstraints = false
         tv.backgroundColor = .white
         tv.delegate = self
         tv.dataSource = self
         tv.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.cellId)
         return tv
     }()
    
    lazy private var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = .lightGray
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        fetchLaunchDetail()
        // Do any additional setup after loading the view.
    }
    

}

private extension LaunchesDetailViewController {
    @objc
    func fetchLaunchDetail() {
        guard let flightNumber = flightNumber else { return  }
        indicatorView.startAnimating()
        launchViewModel.fetchLaunchesDetail(flightNumber){[weak self] result in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                self?.detailTableView.reloadData()
                self?.fetchRocketDetail()
                switch result {
                    case .success( _):break
                    case .failure(let error):
                    self?.showAlert(title: CustomMessage.appName.rawValue, message: error.localizedDescription, actionTexts: [CustomMessage.ok.rawValue], completion: nil)
                }
            }
        }
    }
}

private extension LaunchesDetailViewController {
    @objc
    func fetchRocketDetail() {
        guard let rocketId = rocketId else { return  }
        indicatorView.startAnimating()
        rocketViewModel.fetchRocketsDetail(rocketId){[weak self] result in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                self?.detailTableView.reloadData()
                switch result {
                    case .success( _):break
                    case .failure(let error):
                    self?.showAlert(title: CustomMessage.appName.rawValue, message: error.localizedDescription, actionTexts: [CustomMessage.ok.rawValue], completion: nil)
                }
            }
        }
    }
}

private extension LaunchesDetailViewController {
    func setUPUI() {
        view.backgroundColor = .black
        view.addSubview(detailTableView)
        view.addSubview(indicatorView)
        detailTableView.addConstraintsToFitToSuperview()
        indicatorView.addConstaintsToCenterVertically()
        indicatorView.addConstaintsToCenterHorizontally()

    }
}


extension LaunchesDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (launchViewModel.launchCellViewModel == nil && rocketViewModel.rocketViewModelCell == nil ) ? 0 : (rocketViewModel.rocketViewModelCell == nil ? 1 : 2)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellId, for: indexPath) as? DetailTableViewCell else {return UITableViewCell()}
        cell.selectionStyle  = .none
        cell.descriptionTextView.text =  (indexPath.row == 0) ? (launchViewModel.launchCellViewModel?.completeDetail) : (rocketViewModel.rocketViewModelCell?.completeDetail)
        return cell
    }
    
}

extension LaunchesDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
