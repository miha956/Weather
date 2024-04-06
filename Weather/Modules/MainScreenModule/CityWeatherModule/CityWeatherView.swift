//
//  CityWeatherView.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import UIKit
import SnapKit

class CityWeatherView: UIViewController {

    // MARK: SubViews
    
    private var currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dayliWeatherTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.registerCell(cellClass: HourlyTableViewCell.self)
        tableView.registerCell(cellClass: DailyWeatherTableViewCell.self)
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
    
    // MARK: Private
    
    func setupView() {
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = addCityBarButton
        navigationItem.leftBarButtonItem = cideMenuBarButton
        addSubViews(currentWeatherView,dayliWeatherTableView)
        
        currentWeatherView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        dayliWeatherTableView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

    // MARK: TableView delegate&dataSourse

extension CityWeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let hourlyWeatherCell = tableView.dequeue(cellClass: HourlyTableViewCell.self, indexPath: indexPath)
        let dailyWeatherCell = tableView.dequeue(cellClass: DailyWeatherTableViewCell.self, indexPath: indexPath)
        
        switch indexPath.section {
        case 1:
            return dailyWeatherCell
        default:
            hourlyWeatherCell.collectionViewDataSourceDelegate(dataSourceDelegate: self)
            return hourlyWeatherCell
        }
    }
}

    // MARK: CollectionView delegate&dataSourse

extension CityWeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionHourlyCell = collectionView.dequeue(cellClass: HourlyCollectionViewCell.self, indexPath: indexPath)
        collectionHourlyCell.configView(hour: "123", weatherImage: UIImage(systemName: "house")!, temperature: "23")
        return collectionHourlyCell
    }
    
    
}
