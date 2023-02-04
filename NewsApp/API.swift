//
//  API.swift
//  NewsApp
//
//  Created by Alexander Zub on 04.02.2023.
//

import Foundation

final class API {
    static let shared = API()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=3887fe2e122c41dab41fd62d9d5e7513")
    }
    
    private init() {}
    public func getTopStories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String

}

struct Source: Codable {
    let name: String
}
