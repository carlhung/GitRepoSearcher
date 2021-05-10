//
//  ModelRequest.swift
//  GitRepoSearcher
//
//  Created by carlhung on 10/5/2021.
//

import Foundation

func modelRequest<Model: Codable>(search keyword: String, completionHandler: @escaping (Result<Model, Error>) -> Void) {
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
    if !keyword.isEmpty,
       let url = URLComponents(scheme: "https", host: "api.github.com", path: "/search/repositories", queryItems: [
                                URLQueryItem(name: "q", value: keyword),
                                sortQuery,
                                orderQuery,
                                maxPerPageQuery,
                                pageQuery,
       ]).url {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(.failure(error!))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(ModelError.notHttpURLResponse))
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    completionHandler(.failure(ModelError.not200Response))
                    return
                }
                guard let data = data else {
                    completionHandler(.failure(ModelError.cannotUpwrapData))
                    return
                }
                do {
                    let returnedSearchModel = try JSONDecoder().decode(Model.self, from: data)
                    completionHandler(.success(returnedSearchModel))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }
        .resume()
    }
}

enum ModelError: Error {
    case notHttpURLResponse
    case not200Response
    case cannotUpwrapData
}
