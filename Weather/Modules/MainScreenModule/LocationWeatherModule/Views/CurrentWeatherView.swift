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
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private let tempStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
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
        
        addSubViews(cityNameLabel,temperatureLabel,weatherDescriptionLabel,tempStackview)
        tempStackview.addArrangedSubview(tempMaxLabel)
        tempStackview.addArrangedSubview(tempMinLabel)
        
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
        tempStackview.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview { $0.snp.bottom }
        }
    }
    
    // MARK: PUblic
    
    func confingView(cityName: String, temperature: String, weatherDescription: String, tempMax: String, tempMin: String) {
        cityNameLabel.text = cityName
        temperatureLabel.text = "\(temperature)\u{00B0}"
        weatherDescriptionLabel.text = weatherDescription
        tempMaxLabel.text = "Макс.:\(tempMax)\u{00B0},"
        tempMinLabel.text = "Мин.:\(tempMin)\u{00B0}"
    }
    
}
