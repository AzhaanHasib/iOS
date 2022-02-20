//
//  LaunchesViewController.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import UIKit



class LaunchesViewController: UIViewController {
    

    // MARK: - Properties -
    private let viewModel = LaunchViewModel(apiManager: LaunchesAPIManager())
    private let sortTypeList = [SortType.byDate, SortType.byName, SortType.none]
    private var currentSortType = SortType.none
    private var isFilterOn = false
    private var isLoadingList = false
    private var isAllDataLoaded = false
    var picker = CustomPickerView()
    var toolBar = CustomToolbar()

    lazy private var launchTableView: UITableView = {
         let tv = UITableView(frame: .zero, style: .plain)
         tv.translatesAutoresizingMaskIntoConstraints = false
         tv.backgroundColor = .white
         tv.delegate = self
         tv.dataSource = self
         tv.register(CustomTableCell.self, forCellReuseIdentifier: CustomTableCell.cellId)
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
        fetchLaunches()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction -
    
    @IBAction func sortClicked(sender: Any) {
        picker = CustomPickerView.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - DefaulFrameSize.pickerViewHeight.rawValue, width: UIScreen.main.bounds.size.width, height: DefaulFrameSize.pickerViewHeight.rawValue))
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(sortTypeList.firstIndex(of: currentSortType) ?? 0, inComponent: 0, animated: true)
        self.view.addSubview(picker)
        toolBar = CustomToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - DefaulFrameSize.pickerViewHeight.rawValue, width: UIScreen.main.bounds.size.width, height: DefaulFrameSize.toolBarHeight.rawValue))
        toolBar.toolbarDelegate = self
        self.view.addSubview(toolBar)
    }
    
    @IBAction func filterClicked(sender: Any) {
        showAlert( title: CustomMessage.appName.rawValue, message: !isFilterOn ?  (CustomMessage.filterAddMsg.rawValue) : (CustomMessage.filterRemoveMsg.rawValue), actionTexts: [CustomMessage.yes.rawValue,CustomMessage.no.rawValue]) { [weak self] index in
            self?.indicatorView.startAnimating()
            if self?.isFilterOn ?? false {
                self?.isFilterOn = (index == 1)
            } else {
                self?.isFilterOn = (index == 0)
            }
            self?.updateViewModel()
        }
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}

private extension LaunchesViewController {
    func setUPUI() {
        view.backgroundColor = .white
        view.addSubview(launchTableView)
        view.addSubview(indicatorView)
        launchTableView.addConstraintsToFitToSuperview()
        indicatorView.addConstaintsToCenterVertically()
        indicatorView.addConstaintsToCenterHorizontally()
    }
}


private extension LaunchesViewController {
    @objc
    func fetchLaunches() {
        isLoadingList = true
        indicatorView.startAnimating()
        viewModel.fetchLaunches{[weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingList = false
                self?.indicatorView.stopAnimating()
                switch result {
                    case .success(let models):
                    self?.isAllDataLoaded = models.count == 0
                    self?.updateView()
                    case .failure(let error):
                    self?.showAlert(title: CustomMessage.appName.rawValue, message: error.localizedDescription, actionTexts: [CustomMessage.ok.rawValue], completion: nil)
                }
            }
        }
    }
    
    func updateView(){
        self.launchTableView.reloadData()
    }
    
    func updateViewModel() {
        self.indicatorView.stopAnimating()
        self.viewModel.filterAndSortLaunches( currentSortType, isFilterOn)
        self.launchTableView.reloadData()
       
    }
    
}

extension LaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launcheCellViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCell.cellId, for: indexPath) as? CustomTableCell else {return UITableViewCell()}
        cell.selectionStyle  = .none
        let launchVM = viewModel.launcheCellViewModel?[indexPath.row]
        cell.nameLabel.text = launchVM?.name
        cell.numberLabel.text = launchVM?.launchDateString
        return cell
    }
    
}

extension LaunchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (viewModel.launcheCellViewModel?.count ?? 0) - 1
        if !isLoadingList && indexPath.row == lastItem   && !isAllDataLoaded  {
            fetchLaunches()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: LaunchesDetailViewController.self)) as? LaunchesDetailViewController else {return}
        detailVC.rocketId = viewModel.launcheCellViewModel?[indexPath.row].rocketId
        detailVC.flightNumber = viewModel.launcheCellViewModel?[indexPath.row].flightNumber
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
        picker.isHidden = true
        toolBar.isHidden = true
        picker.removeFromSuperview()
        toolBar.removeFromSuperview()
        updateViewModel()
    }

}
