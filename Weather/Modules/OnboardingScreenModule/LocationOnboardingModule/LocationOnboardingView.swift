//
//  LocationOnboardingView.swift
//  Weather
//
//  Created by Миша Вашкевич on 02.04.2024.
//

import Foundation
import UIKit
import SnapKit

final class LocationOnboardingView: UIViewController {
    
    // MARK: Properties
    
    private let modelView: LocationOnboardingViewModelProtocol
    
    // MARK: SubViews
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "welcomeImage")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let warningTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Разрешить приложению Weather использовать данные о местоположении вашего устройства"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = """
                    Чтобы получить более точные прогнозы погоды во время движения или путешествия
                    
                    Вы можете изменить свой выбор в любое время из меню приложения
                    """
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14, weight: .light)
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    private let confirmUsingLocationButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Разрешить использование геолокации", for: .normal)
        view.backgroundColor = .systemGray
        view.tintColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let cencelUsingLocationButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Пропустить", for: .normal)
        view.tintColor = .systemBlue
        return view
    }()
    
    
    // MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    init(modelView: LocationOnboardingViewModelProtocol) {
        self.modelView = modelView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    
    // MARK: Private
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        addSubViews(imageView,
                    warningTitleLabel,
                    descriptionLabel,
                    confirmUsingLocationButton,
                    cencelUsingLocationButton)
        
        imageView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(120)
            $0.leading.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().offset(-100)
        })
        warningTitleLabel.snp.makeConstraints({
            $0.top.equalTo(imageView.snp_bottomMargin).offset(50)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        })
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(warningTitleLabel.snp_bottomMargin).offset(50)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        })
        confirmUsingLocationButton.snp.makeConstraints({
            $0.top.equalTo(descriptionLabel.snp_bottomMargin).offset(40)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(40)
        })
        cencelUsingLocationButton.snp.makeConstraints({
            $0.top.equalTo(confirmUsingLocationButton.snp_bottomMargin).offset(10)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(40)
        })
        
    }
    
}
