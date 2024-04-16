//
//  SearchScreenModule.swift
//  Weather
//
//  Created by Миша Вашкевич on 13.04.2024.
//

import Foundation
import UIKit

final class SearchLocationView: UIViewController {
    
    private let headerTitle: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "Погода"
        cityLabel.textColor = .white
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    deinit {
        print("SearchLocationView deinit")
    }
}
