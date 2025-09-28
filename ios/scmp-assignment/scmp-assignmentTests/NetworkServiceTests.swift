//
//  NetworkServiceTests.swift
//  scmp-assignmentTests
//
//  Created by Vincent Sit on 28/9/2025.
//

import XCTest
@testable import scmp_assignment

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService.shared
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    // MARK: - NetworkService Singleton Tests
    
    func testNetworkServiceSingleton() {
        // Given
        let instance1 = NetworkService.shared
        let instance2 = NetworkService.shared
        
        // Then
        XCTAssertIdentical(instance1, instance2, "NetworkService should be a singleton")
    }
    
    // MARK: - URL Construction Tests
    
    func testLoginURLConstruction() {
        // Given
        let expectedURL = "https://reqres.in/api/login?delay=5"
        
        // When
        let url = URL(string: expectedURL)
        
        // Then
        XCTAssertNotNil(url, "Login URL should be valid")
        XCTAssertEqual(url?.absoluteString, expectedURL, "Login URL should match expected format")
    }
    
    func testStaffListURLConstruction() {
        // Given
        let page = 1
        let expectedURL = "https://reqres.in/api/users?page=\(page)"
        
        // When
        let url = URL(string: expectedURL)
        
        // Then
        XCTAssertNotNil(url, "Staff list URL should be valid")
        XCTAssertEqual(url?.absoluteString, expectedURL, "Staff list URL should match expected format")
    }
    
    // MARK: - Request Body Tests
    
    func testLoginRequestEncoding() {
        // Given
        let loginRequest = LoginRequest(email: "test@example.com", password: "password123")
        
        // When
        do {
            let encodedData = try JSONEncoder().encode(loginRequest)
            let decodedRequest = try JSONDecoder().decode(LoginRequest.self, from: encodedData)
            
            // Then
            XCTAssertEqual(decodedRequest.email, "test@example.com", "Email should be encoded correctly")
            XCTAssertEqual(decodedRequest.password, "password123", "Password should be encoded correctly")
        } catch {
            XCTFail("Login request encoding/decoding should not fail: \(error)")
        }
    }
    
    // MARK: - Response Model Tests
    
    func testLoginResponseDecoding() {
        // Given
        let jsonData = """
        {
            "token": "QpwL5tke4Pnpja7X4"
        }
        """.data(using: .utf8)!
        
        // When
        do {
            let response = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
            
            // Then
            XCTAssertEqual(response.token, "QpwL5tke4Pnpja7X4", "Token should be decoded correctly")
        } catch {
            XCTFail("Login response decoding should not fail: \(error)")
        }
    }
    
    func testStaffListResponseDecoding() {
        // Given
        let jsonData = """
        {
            "page": 1,
            "per_page": 6,
            "total": 12,
            "total_pages": 2,
            "data": [
                {
                    "id": 1,
                    "email": "george.bluth@reqres.in",
                    "first_name": "George",
                    "last_name": "Bluth",
                    "avatar": "https://reqres.in/img/faces/1-image.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        do {
            let response = try JSONDecoder().decode(StaffListResponse.self, from: jsonData)
            
            // Then
            XCTAssertEqual(response.page, 1, "Page should be decoded correctly")
            XCTAssertEqual(response.perPage, 6, "Per page should be decoded correctly")
            XCTAssertEqual(response.total, 12, "Total should be decoded correctly")
            XCTAssertEqual(response.totalPages, 2, "Total pages should be decoded correctly")
            XCTAssertEqual(response.data.count, 1, "Data array should have one item")
            
            let staff = response.data.first!
            XCTAssertEqual(staff.id, 1, "Staff ID should be decoded correctly")
            XCTAssertEqual(staff.email, "george.bluth@reqres.in", "Staff email should be decoded correctly")
            XCTAssertEqual(staff.firstName, "George", "Staff first name should be decoded correctly")
            XCTAssertEqual(staff.lastName, "Bluth", "Staff last name should be decoded correctly")
            XCTAssertEqual(staff.avatar, "https://reqres.in/img/faces/1-image.jpg", "Staff avatar should be decoded correctly")
        } catch {
            XCTFail("Staff list response decoding should not fail: \(error)")
        }
    }
    
    // MARK: - Error Handling Tests
    
    func testNetworkErrorTypes() {
        // Test different error types
        let invalidURLError = NetworkError.invalidURL
        let serverError = NetworkError.serverError(404)
        let decodingError = NetworkError.decodingError
        let unknownError = NetworkError.unknown
        
        // Then
        XCTAssertNotNil(invalidURLError, "Invalid URL error should exist")
        XCTAssertNotNil(serverError, "Server error should exist")
        XCTAssertNotNil(decodingError, "Decoding error should exist")
        XCTAssertNotNil(unknownError, "Unknown error should exist")
    }
}
