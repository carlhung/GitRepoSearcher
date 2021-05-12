//
//  SearchView.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchText(string: String)
}

class SearchView: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    private let enterButton = UIButton()
    private let searchTextField = UITextField()
    private weak var delegate: SearchViewDelegate?
    private var totalWidth: CGFloat!
    
    // MARK: - Init
    init(buttonWidthAndHeight: CGFloat, availableWidth: CGFloat, delegate: SearchViewDelegate) {
        super.init(frame: .zero)
        self.setup(buttonWidthAndHeight: buttonWidthAndHeight, availableWidth: availableWidth, delegate: delegate)
    }
    
    @available(*, unavailable, message: "This shouldn't be used. use init(buttonWidthAndHeight:availableWidth:delegate:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    func setup(buttonWidthAndHeight: CGFloat, availableWidth: CGFloat, delegate: SearchViewDelegate) {
        self.setupSelf(availableWidth: availableWidth, buttonWidthAndHeight: buttonWidthAndHeight, delegate: delegate)
        self.setupEnterButton(buttonWidthAndHeight: buttonWidthAndHeight)
        self.setupSearchTextField(buttonWidthAndHeight: buttonWidthAndHeight)
    }
    
    func setupSelf(availableWidth: CGFloat, buttonWidthAndHeight: CGFloat, delegate: SearchViewDelegate) {
        self.delegate = delegate
        self.totalWidth = availableWidth
        self.frame.size.width = availableWidth
        self.frame.size.height = buttonWidthAndHeight
    }
    
    func setupEnterButton(buttonWidthAndHeight: CGFloat) {
        self.enterButton.setTitleColor(.blue, for: .normal)
        self.enterButton.setTitle("Search", for: .normal)
        self.enterButton.backgroundColor = .gray
        self.enterButton.frame = CGRect(x: self.totalWidth - buttonWidthAndHeight,
                                        y: 0,
                                        width: buttonWidthAndHeight,
                                        height: buttonWidthAndHeight)
        self.enterButton.addTarget(self, action: #selector(self.searchPressed), for: .touchUpInside)
        self.addSubview(self.enterButton)
    }
    
    func setupSearchTextField(buttonWidthAndHeight: CGFloat) {
//        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.searchTextField.delegate = self
        self.searchTextField.placeholder = "Repo keyword"
        self.searchTextField.keyboardType = .default
        self.searchTextField.autocapitalizationType = .none
        self.searchTextField.returnKeyType = .search
        self.searchTextField.autocorrectionType = .yes
        self.searchTextField.font = .systemFont(ofSize: 20)
        self.searchTextField.borderStyle = .roundedRect
        self.searchTextField.clearButtonMode = .whileEditing
        self.searchTextField.contentVerticalAlignment = .center
        self.searchTextField.frame.size = CGSize(width: self.totalWidth - buttonWidthAndHeight, height: self.frame.height)
        self.addSubview(self.searchTextField)
    }
    
    // MARK: - Button Events
    @objc
    func searchPressed() {
        print("SearchView searchPressed")
        if let text = self.searchTextField.text {
            delegate?.searchText(string: text)
        }
    }
    
    // MARK: - UITextFieldDelegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            delegate?.searchText(string: text)
        }
        textField.resignFirstResponder()
        return true
    }
}

//extension SearchView: UITextFieldDelegate {
////    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
////        // return NO to disallow editing.
////        print("TextField should begin editing method called")
////        return true
////    }
////
////    func textFieldDidBeginEditing(_ textField: UITextField) {
////        // became first responder
////        print("TextField did begin editing method called")
////    }
////
////    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
////        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
////        print("TextField should snd editing method called")
////        return true
////    }
////
////    func textFieldDidEndEditing(_ textField: UITextField) {
////        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
////        print("TextField did end editing method called")
////    }
////
////    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
////        // if implemented, called in place of textFieldDidEndEditing:
////        print("TextField did end editing with reason method called")
////    }
////
////    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        // return NO to not change text
////        print("While entering the characters this method gets called")
////        return true
////    }
////
////    func textFieldShouldClear(_ textField: UITextField) -> Bool {
////        // called when clear button pressed. return NO to ignore (no notifications)
////        print("TextField should clear method called")
////        return true
////    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // called when 'return' key pressed. return NO to ignore.
////        print("TextField should return method called")
//        // may be useful: textField.resignFirstResponder()
//        if let text = textField.text {
//            print("textFieldShouldReturn: \(text)")
//        }
//        textField.resignFirstResponder()
//        return true
//    }
//}
