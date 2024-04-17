//
//  SearchScreenModule.swift
//  Weather
//
//  Created by Миша Вашкевич on 13.04.2024.
//

import Foundation
import UIKit

final class SearchLocationView: UIViewController {
    
    // MARK: Properties

    private let viewModel: SearchLocationViewModelProtocol
    
    // MARK: SubViews
    
    private let headerTitle: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Погода"
        cityLabel.textColor = .black
        return cityLabel
    }()
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.showsCancelButton = false
        searchBar.tintColor = .white
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск города",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
       return searchBar
   }()
    private let locationListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tag = 1
        return tableView
    }()
    private var searchResultsTable: UITableView = {
          let searchResultsTable = UITableView(frame: .zero, style: .plain)
          searchResultsTable.tag = 2
          searchResultsTable.showsVerticalScrollIndicator = false
          searchResultsTable.backgroundColor = .black
          searchResultsTable.separatorStyle = .none
          return searchResultsTable
      }()
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: SearchLocationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("SearchLocationView deinit")
    }
    
    // MARK: Private
    
    private func setupView() {
        
    }
}
