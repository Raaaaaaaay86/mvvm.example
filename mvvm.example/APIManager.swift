//
//  APIManager.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import Foundation

enum API {
    static let GetRandomUser = URL(string: "https://randomuser.me/api/")
}

enum APIError: Error {
    case InvalidURL
    case Unknown
}

class APIManager {
    
    static var shared: APIManager?
    
    private var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    
    private var timeout: TimeInterval = 60
    
    init(cachePolicy: URLRequest.CachePolicy, timeout: TimeInterval) {
        self.cachePolicy = cachePolicy
        self.timeout = timeout
        APIManager.shared = self
    }
    
    func GET<T: Codable>(
        _ url: URL?,
        responseType: T.Type ,
        completionBlock:((_ data: T?, _ response: URLResponse?, _ error: Error?) -> Void)?
    ) {
        guard let url = url else {
            completionBlock?(nil, nil, APIError.InvalidURL)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionBlock?(nil, nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 1992-03-08T15:13:16.688Z
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                let responseData = try decoder.decode(responseType, from: data)
                completionBlock?(responseData, response, nil)
            } catch {
                completionBlock?(nil, response, error)
            }
        }.resume()
    }
}
