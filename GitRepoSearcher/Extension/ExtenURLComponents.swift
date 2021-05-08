//
//  ExtenURLComponents.swift
//  GitRepoSearcher
//
//  Created by carlhung on 8/5/2021.
//

import Foundation

extension URLComponents {
    init(scheme: String,// = "https",
         host: String,// = "www.google.com",
         path: String,// = "/search",
         queryItems: [URLQueryItem]) { // URLQueryItem(name: "q", value: "Formula One")
        self.init()
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}
