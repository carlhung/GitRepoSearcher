//
//  ViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit
import Foundation

class SearchViewController: UIViewController, SearchViewDelegate {

    class var searchViewWidthAndHeight: CGFloat {
        60
    }
    
    class var defaultUITableViewCellIdentifier: String {
        "Cell"
    }
    
    private var searchView: SearchView!
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    var itemArray: [Items] = []

    // MARK: - Setup
    func setup() {
        
        self.setupSearchView(widthAndHeight: Self.searchViewWidthAndHeight)
        self.setupTableView()
    }
    
    func setupSearchView(widthAndHeight: CGFloat) {
        self.searchView = SearchView(buttonWidthAndHeight: widthAndHeight, availableWidth: self.safeAreaFrame.width, delegate: self)
        self.searchView.frame.origin.y = self.safeAreaFrame.origin.y
        self.view.addSubview(self.searchView)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.defaultUITableViewCellIdentifier)
        self.tableView.frame = CGRect(x: self.safeAreaFrame.origin.x, y: self.searchView.frame.origin.y + self.searchView.frame.height, width: self.safeAreaFrame.width, height: self.safeAreaFrame.height - self.searchView.frame.height)
        self.view.addSubview(self.tableView)
    }
    
    
    // MARK: - Delegate method
    func searchText(string: String) {
        /*
         curl \
           -H "Accept: application/vnd.github.v3+json" \
           "https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc"
         */
        
        // The results are sorted by stars in descending order, so that the most popular repositories appear first in the search results.
        let sortQuery = URLQueryItem(name: "sort", value: "stars")
        let orderQuery = URLQueryItem(name: "order", value: "desc")
        let maxPerPageQuery = URLQueryItem(name: "per_page", value: "100")
        let pageQuery = URLQueryItem(name: "page", value: "1")
        if !string.isEmpty,
           let url = URLComponents(scheme: "https", host: "api.github.com", path: "/search/repositories", queryItems: [
                                    URLQueryItem(name: "q", value: string),
                                    sortQuery,
                                    orderQuery,
                                    maxPerPageQuery,
                                    pageQuery,
           ]).url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request, completionHandler: { [unowned self] (data: Data?, response: URLResponse?, error: Error?) in
                DispatchQueue.main.async {
                    guard error == nil else {
                        print("SearchViewController searchText error: \(error!)")
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("SearchViewController searchText: can't cast to HTTPURLResponse")
                        return
                    }
                    guard httpResponse.statusCode == 200 else {
                        print("SearchViewController searchText, other statusCode: \(httpResponse.statusCode)")
                        return
                    }
                    guard let data = data else {
                        print("SearchViewController searchText, Can't unwrap data")
                        return
                    }
//                    print("SearchViewController searchText data: \(String(decoding: data, as: UTF8.self))")
                    do {
                        let returnedSearchModel = try JSONDecoder().decode(ReturnedSearchModel.self, from: data)
//                        print("item count: \(returnedSearchModel.items?.count), total Count: \(returnedSearchModel.total_count)")
                        self.itemArray = returnedSearchModel.items ?? []
                        self.tableView.reloadData()
                    } catch {
                        print("SearchViewController searchText, catch error: \(error)")
                    }
                    
                }
            })
                .resume()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let returnedCell = tableView.dequeueReusableCell(withIdentifier: Self.defaultUITableViewCellIdentifier) {
            cell = returnedCell
        } else {
            cell = UITableViewCell()
        }
        cell.textLabel?.text = self.itemArray[indexPath.row].name
        return cell
    }
    
    
}
