//
//  LocationsPageController.swift
//  Weather
//
//  Created by Миша Вашкевич on 15.04.2024.
//
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
    private lazy var pageViewController: UIPageViewController = {
        let view = UIPageViewController(transitionStyle: .scroll,
                                        navigationOrientation: .horizontal)
        view.delegate = self
        view.dataSource = self
        if let firstViewController = locationView.first {
            view.setViewControllers([firstViewController], 
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
        return view
    }()
    private lazy var addLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(addLOcationButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var cideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("=", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        return button
    }()
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .white
        pageControl.numberOfPages = numberOfPages
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        return pageControl
    }()
    // MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .clear
        addChild(pageViewController)
        addSubViews(pageControl, pageViewController.view,addLocationButton,cideMenuButton)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(addLocationButton.snp.leading)
            make.leading.equalTo(cideMenuButton.snp.trailing)
            make.height.equalTo(40)
        }
        addLocationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(pageControl)
            make.height.width.equalTo(40)
        }
        cideMenuButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(pageControl)
            make.height.width.equalTo(40)
        }
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Actions
    
    @objc private func addLOcationButtonTapped() {
        viewModel.goToAddLocationView()
    }
    @objc private func showSideMenu() {
        viewModel.presentSideMenu()
    }
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        pageViewController.setViewControllers([locationView[currentPage]], direction: .forward, animated: true)
    }
}

    // MARK: PageView Delegate&DataSource

extension LocationsPageView: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = locationView.firstIndex(of: viewController) {
            if index > 0 {
                return locationView[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = locationView.firstIndex(of: viewController) {
            if index < locationView.count - 1 {
                return locationView[index + 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let firstViewController = pendingViewControllers.first,
              let index = locationView.firstIndex(of: firstViewController) else {
            return
        }
        pageControl.currentPage = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let firstViewController = pageViewController.viewControllers?.first,
              let index = locationView.firstIndex(of: firstViewController) else {
            return
        }
        pageControl.currentPage = index
    }
}
