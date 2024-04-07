//
//  HourlyWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import Foundation
import UIKit
import SnapKit

final class HourlyCollectionViewCell: UICollectionViewCell {
    
    // MARK: Subviews
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        
        contentView.addSubViews(hourLabel,weatherImageView,tempLabel)
        
    
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.trailing.leading.equalTo(contentView)
        }
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(5)
            make.width.height.equalTo(25)
            make.centerX.equalTo(contentView)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
            make.trailing.leading.equalTo(contentView)
        }
    }
    
    // MARK: Public
    
    func configView(hour: String, weatherImage: UIImage, temperature: String) {
        hourLabel.text = hour
        weatherImageView.image = weatherImage
        tempLabel.text = "\(temperature)\u{00B0}"
    }
    
}
