//
//  SearchView.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit
import SnapKit

protocol SearchViewDelegate {
    func searchText(string: String)
}

class SearchView: UIView, UITextFieldDelegate {
    private let enterButton = UIButton()
    private let searchTextField = UITextField()
    private var delegate: SearchViewDelegate!
    
    init(widthAndHeight: CGFloat, delegate: SearchViewDelegate) {
        super.init(frame: .zero)
        self.setup(widthAndHeight: widthAndHeight, delegate: delegate)
    }
    
    @available(*, unavailable, message: "This should be used. use init() instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(widthAndHeight: CGFloat, delegate: SearchViewDelegate) {
        self.setupSelf(delegate: delegate)
        self.setupEnterButton(widthAndHeight: widthAndHeight)
        self.setupSearchTextField()
    }
    
    func setupSelf(delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    func setupEnterButton(widthAndHeight: CGFloat) {
        self.enterButton.setTitleColor(.blue, for: .normal)
        self.enterButton.setTitle("Search", for: .normal)
        self.enterButton.backgroundColor = .gray
        self.enterButton.addTarget(self, action: #selector(self.searchPressed), for: .touchUpInside)
        self.addSubview(self.enterButton)
        self.enterButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(widthAndHeight)
        }
    }
    
    func setupSearchTextField() {
//        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.searchTextField.delegate = self
        self.searchTextField.placeholder = "Repo keyword"
        self.searchTextField.keyboardType = .default
        self.searchTextField.returnKeyType = .search
        self.searchTextField.autocorrectionType = .yes
        self.searchTextField.font = .systemFont(ofSize: 20)
        self.searchTextField.borderStyle = .roundedRect
        self.searchTextField.clearButtonMode = .whileEditing
        self.searchTextField.contentVerticalAlignment = .center
        self.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.right.equalTo(self.enterButton.snp.left)
        }
    }
    
    @objc
    func searchPressed() {
        print("SearchView searchPressed")
        if let text = self.searchTextField.text {
            delegate.searchText(string: text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            delegate.searchText(string: text)
        }
        textField.resignFirstResponder()
        return true
    }
}
