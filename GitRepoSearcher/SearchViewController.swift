//
//  ViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    class var searchViewWidthAndHeight: CGFloat {
        return 60
    }
    
    var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        self.setupSearchView(widthAndHeight: Self.searchViewWidthAndHeight)
    }
    
    func setupSearchView(widthAndHeight: CGFloat) {
        self.searchView = SearchView(widthAndHeight: widthAndHeight)
        self.view.addSubview(self.searchView)
        self.searchView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(widthAndHeight)
        }
    }
}

