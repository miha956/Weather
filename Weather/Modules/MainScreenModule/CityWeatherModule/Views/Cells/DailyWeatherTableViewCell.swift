//
//  DailyWeatherTableViewCell.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import UIKit
import SnapKit

final class DailyWeatherTableViewCell: UITableViewCell {
    
    private let titlet = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        contentView.addSubview(titlet)
        
        titlet.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func config(title: String) {
        titlet.text = title
        titlet.textColor = .black
        titlet.textAlignment = .center
        titlet.font = .systemFont(ofSize: 20)
    }
}
