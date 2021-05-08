//
//  ViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, SearchViewDelegate {

    class var searchViewWidthAndHeight: CGFloat {
        return 60
    }
    
    private var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        self.setupSearchView(widthAndHeight: Self.searchViewWidthAndHeight)
    }
    
    func setupSearchView(widthAndHeight: CGFloat) {
        self.searchView = SearchView(widthAndHeight: widthAndHeight, delegate: self)
        self.view.addSubview(self.searchView)
        self.searchView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(widthAndHeight)
        }
    }
    
    
    // MARK: - Delegate method
    func searchText(string: String) {
        guard !string.isEmpty else { return }
        print("SearchViewController searchText: \(string)")
    }
}
//
//extension SearchViewController: UITextFieldDelegate {
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
