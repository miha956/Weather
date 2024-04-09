//
//  DailyWeatherTableViewCell.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import UIKit
import SnapKit

final class DailyWeatherTableViewCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let chanceRainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    private let chanceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let imageRainChanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 1
        return stackView
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private let tempStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        [minTempLabel, maxTempLabel].forEach {tempStackview.addArrangedSubview($0)}
        imageRainChanceStackView.addArrangedSubview(weatherImageView)
        backgroundColor = .clear
        contentView.addSubViews(dateLabel,
                                imageRainChanceStackView,
                                tempStackview)
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(80)
        }
        weatherImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        imageRainChanceStackView.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        tempStackview.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func config(date: String, weatherImage: UIImage, chanceOfRain: String?, minTemp: String, maxTemp: String) {
        self.dateLabel.text = date
        self.weatherImageView.image = weatherImage
        
        if let rainChance = chanceOfRain {
            imageRainChanceStackView.addArrangedSubview(chanceRainLabel)
            self.chanceRainLabel.text = "\(rainChance)\u{0025}"
        }
        self.minTempLabel.text = "\(minTemp)\u{00B0}"
        self.maxTempLabel.text = "\(maxTemp)\u{00B0}"
    }
}
