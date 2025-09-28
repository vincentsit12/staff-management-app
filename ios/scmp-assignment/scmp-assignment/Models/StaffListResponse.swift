//
//  StaffListResponse.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import Foundation

struct StaffListResponse: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [Staff]
    
    enum CodingKeys: String, CodingKey {
        case page, data, total
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}
