//
//  ViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 7/5/2021.
//

import UIKit
import SnapKit
import Foundation

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
        /*
         curl \
           -H "Accept: application/vnd.github.v3+json" \
           "https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc"
         */
        
        // The results are sorted by stars in descending order, so that the most popular repositories appear first in the search results.
        let sortQuery = URLQueryItem(name: "sort", value: "stars")
        let orderQuery = URLQueryItem(name: "order", value: "desc")
        if !string.isEmpty,
           let url = URLComponents(scheme: "https", host: "api.github.com", path: "/search/repositories", queryItems: [
                                    URLQueryItem(name: "q", value: string),
                                    sortQuery,
                                    orderQuery,
           ]).url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
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
                    print("SearchViewController searchText data: \(String(decoding: data, as: UTF8.self))")
//                    do {
//                        let returnedSearchModel = try JSONDecoder().decode(ReturnedSearchModel.self, from: data)
//                    } catch {
//                        print("SearchViewController searchText, catch error: \(error)")
//                    }
                    
                }
            })
                .resume()
        }
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
