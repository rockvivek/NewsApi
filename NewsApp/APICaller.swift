//
//  APICaller.swift
//  NewsApp
//
//  Created by vivek shrivastwa on 15/05/21.
//

import Foundation
import UIKit

/// api caller
final class APICaller {
    
    //static variable
    static let shared = APICaller()
    
    struct Constant {
        
        static let topHeadingURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=529191c775614bb5bb14a1cdf9ac8a74")
    }
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void ){
        guard let url = Constant.topHeadingURL else {
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(error))
            }
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        session.resume()
    }
}

//models
struct Model: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case source, title
        case articleDescription = "description"
        case url, urlToImage
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
