//
//  ConfigurationTests.swift
//  scmp-assignmentTests
//
//  Created by Vincent Sit on 28/9/2025.
//

import XCTest
@testable import scmp_assignment

final class ConfigurationTests: XCTestCase {
    
    // MARK: - Configuration Tests
    
    func testConfigurationApiKey() {
        // When
        let apiKey = Configuration.apiKey
        
        // Then
        XCTAssertFalse(apiKey.isEmpty, "API key should not be empty")
        XCTAssertTrue(apiKey.contains("reqres"), "API key should contain expected value")
    }
}
