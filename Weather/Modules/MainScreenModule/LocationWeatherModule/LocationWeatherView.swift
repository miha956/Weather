//
//  CityWeatherView.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import UIKit
import SnapKit

class LocationWeatherView: UIViewController {
    
    // MARK: Properties
    
    let viewModel: LocationWeatherViewModelProtocol

    // MARK: SubViews
    
    private var currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        return view
    }()
    private lazy var dayliWeatherTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.registerCell(cellClass: HourlyTableViewCell.self)
        tableView.registerCell(cellClass: DailyWeatherTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private lazy var addCityBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil,
                                        style: .plain,
                                        target: self,
                                        action: nil)
        return button
    }()
    private lazy var cideMenuBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil,
                                        style: .plain,
                                        target: self,
                                        action: nil)
        return button
    }()
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(viewModel: LocationWeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    func setupView() {
        
        view.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem = addCityBarButton
        navigationItem.leftBarButtonItem = cideMenuBarButton
        addSubViews(currentWeatherView,dayliWeatherTableView)
        
        currentWeatherView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        dayliWeatherTableView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}

    // MARK: TableView delegate&dataSourse

extension LocationWeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 10
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let hourlyWeatherCell = tableView.dequeue(cellClass: HourlyTableViewCell.self)
        let dailyWeatherCell = tableView.dequeue(cellClass: DailyWeatherTableViewCell.self)
        
        switch indexPath.section {
        case 1:
            return dailyWeatherCell
        default:
            hourlyWeatherCell.collectionViewDataSourceDelegate(dataSourceDelegate: self)
            return hourlyWeatherCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

    // MARK: CollectionView delegate&dataSourse

extension LocationWeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionHourlyCell = collectionView.dequeue(cellClass: HourlyCollectionViewCell.self, indexPath: indexPath)
        return collectionHourlyCell
    }
    
}
