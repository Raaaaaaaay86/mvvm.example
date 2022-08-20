//
//  Person.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import Foundation

struct Person: Codable {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob: DateOfBirth?
    var registered: Registered?
    var phone: String?
    var cell: String?
    var id: ID?
    var picture: Picture?
    var nat: String?
    
    struct Name: Codable {
        var title: String?
        var first: String?
        var last: String?
    }
    
    struct Location: Codable {
        var street: Street?
        var city: String?
        var state: String?
        var country: String?
        var postcode: Int?
        var coordinates: Coordinates?
        var timezone: Timezone?
        
        struct Street: Codable {
            var number: Int?
            var name: String?
        }
        
        struct Coordinates: Codable {
            var latitude: String?
            var longitude: String?
        }
        
        struct Timezone: Codable {
            var offset: String?
            var description: String?
        }
    }
    
    struct Login: Codable {
        var uuid: String?
        var username: String?
        var password: String?
        var salt: String?
        var md5: String?
        var sha256: String?
    }
    
    struct DateOfBirth: Codable {
        var date: Date?
        var age: Int?
    }
    
    struct Registered: Codable {
        var date: Date?
        var age: Int?
    }
    
    struct ID: Codable {
        var name: String?
        var value: String?
    }
    
    struct Picture: Codable {
        var large: String?
        var medium: String?
        var thumbnail: String?
    }
}
