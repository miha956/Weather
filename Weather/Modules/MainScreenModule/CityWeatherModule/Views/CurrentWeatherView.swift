//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import Foundation
import UIKit
import SnapKit

final class CurrentWeatherView: UIView {
    
    // MARK: SubViews
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.alpha = 0
        return label
    }()
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    private let tempMaxMinLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupView() {
        addSubViews(cityNameLabel,temperatureLabel,weatherDescriptionLabel,tempMaxMinLabel)
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        tempMaxMinLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(10)
        }
    }
    
    // MARK: PUblic
    
    func confingView(cityName: String, temperature: String, weatherDescription: String, tempMax: String, tempMin: String) {
        cityNameLabel.text = cityName
        temperatureLabel.text = "\(temperature)\u{00B0}"
        weatherDescriptionLabel.text = weatherDescription
        tempMaxMinLabel.text = "Макс.:\(tempMax)\u{00B0},Мин.:\(tempMin)\u{00B0}"
    }
    
}
