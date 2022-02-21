//
//  LaunchesViewController.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    // MARK: - Properties -
    private let launchViewModelType: LaunchViewModelType = LaunchViewModel(apiManager: LaunchesAPIManager())
    private let sortTypeList = [SortType.byDate, SortType.byName, SortType.none]
    private var currentSortType = SortType.none
    private var isFilterOn = false
    private var isLoadingList = false
    private var isAllDataLoaded = false
    var picker: CustomPickerView?
    var toolBar: CustomToolbar?

    lazy private var launchTableView: UITableView = {
         let tv = UITableView(frame: .zero, style: .plain)
         tv.translatesAutoresizingMaskIntoConstraints = false
         tv.backgroundColor = .white
         tv.delegate = self
         tv.dataSource = self
         tv.register(LaunchListTableViewCell.self, forCellReuseIdentifier: LaunchListTableViewCell.cellId)
         return tv
     }()
    
     private var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = .lightGray
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchLaunches()
        // Do any additional setup after loading the view.
    }

    // MARK: - IBAction -
    
    @IBAction func sortClicked(sender: Any) {
        picker = CustomPickerView.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - DefaulFrameSize.pickerViewHeight, width: UIScreen.main.bounds.size.width, height: DefaulFrameSize.pickerViewHeight))
        toolBar = CustomToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - DefaulFrameSize.pickerViewHeight, width: UIScreen.main.bounds.size.width, height: DefaulFrameSize.toolBarHeight))
        guard let picker = picker, let toolBar =  toolBar else { return  }
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(sortTypeList.firstIndex(of: currentSortType) ?? 0, inComponent: 0, animated: true)
        self.view.addSubview(picker)
        toolBar.toolbarDelegate = self
        self.view.addSubview(toolBar)
    }
    
    @IBAction func filterClicked(sender: Any) {
        showAlert(title: CustomMessage.appName, message: !isFilterOn ?  (CustomMessage.filterAddMsg) : (CustomMessage.filterRemoveMsg), actionTexts: [CustomMessage.yes,CustomMessage.no]) { [weak self] index in
            guard let self = self else { return  }
            self.isFilterOn = (self.isFilterOn) ? (index == 1) : (index == 0)
            self.launchTableView.reloadData()
        }
    }
   }

  private extension LaunchesViewController {
    func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(launchTableView)
        view.addSubview(indicatorView)
        launchTableView.addConstraintsToFitToSuperview()
        indicatorView.addConstaintsToFitCentre()
    }
  }

  private extension LaunchesViewController {
    @objc
    func fetchLaunches() {
        isLoadingList = true
        indicatorView.startAnimating()
        launchViewModelType.fetchLaunches{[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoadingList = false
                self.indicatorView.stopAnimating()
                switch result {
                    case .success(let models):
                    self.isAllDataLoaded = models.count == 0
                    self.updateView()
                    case .failure(let error):
                    self.showAlert(title: CustomMessage.appName, message: error.localizedDescription, actionTexts: [CustomMessage.ok], completion: nil)
                }
            }
        }
    }
    
    func updateView() {
        self.launchTableView.reloadData()
    }
    
    func updateViewModel() {
        self.launchViewModelType.filterAndSortLaunches( currentSortType)
        self.launchTableView.reloadData()
    }
}

extension LaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchViewModelType.getCellViewModels()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchListTableViewCell.cellId, for: indexPath) as? LaunchListTableViewCell else {return UITableViewCell()}
        cell.selectionStyle  = .none
        let launchVM = launchViewModelType.getCellViewModels()?[indexPath.row]
        let detail = isFilterOn ? (launchVM?.launchSuccess ?? false ? launchVM?.minimalLaunchDetail : "" ): launchVM?.minimalLaunchDetail
        cell.configureData(detail)
        return cell
    }
    
}

extension LaunchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (launchViewModelType.getCellViewModels()?.count ?? 0) - 1
        if !isLoadingList && indexPath.row == lastItem   && !isAllDataLoaded  {
            fetchLaunches()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: LaunchesDetailViewController.self)) as? LaunchesDetailViewController else {return}
        detailVC.configureWith(launchViewModelType.getCellViewModels()?[indexPath.row].flightNumber, rocketId: launchViewModelType.getCellViewModels()?[indexPath.row].rocketId)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension LaunchesViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.sortTypeList.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.sortTypeList[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSortType = self.sortTypeList[row]
    }
}

extension LaunchesViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        picker?.isHidden = true
        toolBar?.isHidden = true
        picker?.removeFromSuperview()
        toolBar?.removeFromSuperview()
        picker = nil
        toolBar = nil
        updateViewModel()
    }
}
