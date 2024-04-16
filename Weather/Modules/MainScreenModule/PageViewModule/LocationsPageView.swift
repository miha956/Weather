//
//  LocationsPageController.swift
//  Weather
//
//  Created by Миша Вашкевич on 15.04.2024.
//

import Foundation
import UIKit
import SnapKit

final class LocationsPageView: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: LocationsPageViewModelProtocol
    private var numberOfPages: Int {
        return viewModel.views.count
    }
    var locationView: [UIViewController] {
        viewModel.views
    }
    
    // MARK: SubViews
    
    private let locationsListButton: UIButton = {
        let button = UIButton()
        button.setTitle("list", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .red
        pageControl.numberOfPages = numberOfPages
        pageControl.addTarget(self,
                              action: #selector(pageControlChanged),
                              for: .valueChanged)
        return pageControl
    }()
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.delegate = self
        view.isPagingEnabled = true
        return view
    }()
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(locationView)
        setupView()
    }
    
    init(viewModel: LocationsPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupView() {
        
        navigationController?.isNavigationBarHidden = true
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(locationView.count), height: scrollView.frame.height)
        addSubViews(pageControl,scrollView)
        for i in 0...locationView.count - 1 {
            scrollView.addSubview(locationView[i].view)
            locationView[i].view.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.width.equalTo(self.view)
                make.height.equalToSuperview()
                make.leading.equalTo(CGFloat(i) * self.view.frame.size.width)
            }
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: Actions
    
    @objc private func pageControlChanged(sender: UIPageControl) {
        let currentPage = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.frame.size.width, y: 0), animated: true)
    }
}

    // MARK: UIScrollViewDelegate

extension LocationsPageView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
