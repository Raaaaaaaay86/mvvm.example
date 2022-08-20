//
//  RandomUserAPIResponse.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import Foundation

struct RandomUserAPIResponse: Codable {
    var results: [Person?]?
    var info: Info?
    
    struct Info: Codable {
        var seed: String?
        var results: Int?
        var page: Int?
        var version: String?
    }
}
