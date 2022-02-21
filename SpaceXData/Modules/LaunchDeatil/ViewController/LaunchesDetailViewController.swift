//
//  LaunchesDetailViewController.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import UIKit

class LaunchesDetailViewController: UIViewController {
    
    // MARK: - Properties -
    private let launchViewModelType: LaunchDetailViewModelType = LaunchDetailViewModel.init(apiManager: LaunchesAPIManager())
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
        fetchRocketDetail()
        // Do any additional setup after loading the view.
    }
    
    func configureWith(_ flightNumber: String?, rocketId: String?) {
        self.flightNumber = flightNumber
        self.rocketId = rocketId
    }
}

private extension LaunchesDetailViewController {
    @objc
    func fetchLaunchDetail() {
        guard let flightNumber = flightNumber else { return  }
        indicatorView.startAnimating()
        launchViewModelType.fetchLaunchesDetail(flightNumber){[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                switch result {
                    case .success( _):
                    self.detailTableView.reloadData()
                    case .failure(let error):
                    self.showAlert(title: CustomMessage.appName, message: error.localizedDescription, actionTexts:
                         [CustomMessage.ok], completion: nil)
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
        launchViewModelType.fetchRocketsDetail(rocketId){[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                switch result {
                case .success( _):
                    self.detailTableView.reloadData()
                    case .failure(let error):
                    self.showAlert(title: CustomMessage.appName,
                    message: error.localizedDescription,
                    actionTexts: [CustomMessage.ok], completion: nil)
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
        indicatorView.addConstraintsToFitToSuperview()
    }
}


extension LaunchesDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchViewModelType.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellId, for: indexPath) as? DetailTableViewCell else {return UITableViewCell()}
        cell.selectionStyle  = .none
        let detail = (indexPath.row == 0) ? (launchViewModelType.getCellLaunchViewModel()?.completeLaunchDetail) : (launchViewModelType.getCellRocketViewModel()?.completeDetail)
        cell.configureData(detail: detail)
        return cell
    }
}

extension LaunchesDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
