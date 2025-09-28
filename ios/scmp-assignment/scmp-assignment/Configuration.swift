//
//  Configuration.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import Foundation

struct Configuration {
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}
