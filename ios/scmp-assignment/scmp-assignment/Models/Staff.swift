//
//  Staff.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import Foundation

struct Staff: Codable, Identifiable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}