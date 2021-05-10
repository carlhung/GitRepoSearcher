//
//  ViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit
import Foundation

class SearchViewController: UIViewController, SearchViewDelegate {

    // MARK: - Class properties
    class var searchViewWidthAndHeight: CGFloat {
        60
    }
    
    // MARK: - Properties
    private var searchView: SearchView!
    let tableView = UITableView()
    
    // MARK: - Data
    var itemArray: [Items] = []
    
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    func setup() {
        self.setupSearchView(widthAndHeight: Self.searchViewWidthAndHeight)
        self.setupTableView()
    }
    
    func setupSearchView(widthAndHeight: CGFloat) {
        self.searchView = SearchView(buttonWidthAndHeight: widthAndHeight, availableWidth: self.safeAreaFrame.width, delegate: self)
        let height = navigationController?.navigationBar.frame.maxY
        self.searchView.frame.origin.y = self.safeAreaFrame.origin.y + (height ?? 0)
        self.view.addSubview(self.searchView)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FlavouriteTableViewCell.self, forCellReuseIdentifier: FlavouriteTableViewCell.identifier)
        self.tableView.frame = CGRect(x: 0, y: self.searchView.frame.origin.y + self.searchView.frame.height, width: self.safeAreaFrame.width, height: self.safeAreaFrame.height - self.searchView.frame.height - (navigationController?.navigationBar.frame.maxY ?? 0))
        self.view.addSubview(self.tableView)
    }
    
    
    // MARK: - Delegate method
    func searchText(string: String) {
        modelRequest(search: string) { [unowned self] (result: Result<ReturnedSearchModel, Error>) in
            switch result {
            case .failure(let e):
                print("SearchViewController searchText error: \(e)")
            case .success(let model):
                self.itemArray = model.items ?? []
                self.tableView.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
}

// MARK: - Extension for UITableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlavouriteTableViewCell.identifier) as! FlavouriteTableViewCell
        let text = self.itemArray[indexPath.row].name ?? ""
        cell.renewCell(text: text, flavourited: false, availableWidth: self.tableView.frame.width)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RepoDetailViewController(repo: self.itemArray[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        FlavouriteTableViewCell.cellHeight
    }
}
