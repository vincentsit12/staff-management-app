//
//  ModelsTests.swift
//  scmp-assignmentTests
//
//  Created by Vincent Sit on 28/9/2025.
//

import XCTest
@testable import scmp_assignment

final class ModelsTests: XCTestCase {
    
    // MARK: - Staff Model Tests
    
    func testStaffModelInitialization() {
        // Given
        let staff = Staff(
            id: 1,
            email: "test@example.com",
            firstName: "John",
            lastName: "Doe",
            avatar: "https://example.com/avatar.jpg"
        )
        
        // Then
        XCTAssertEqual(staff.id, 1)
        XCTAssertEqual(staff.email, "test@example.com")
        XCTAssertEqual(staff.firstName, "John")
        XCTAssertEqual(staff.lastName, "Doe")
        XCTAssertEqual(staff.avatar, "https://example.com/avatar.jpg")
        XCTAssertEqual(staff.fullName, "John Doe")
    }
    
    func testStaffFullName() {
        // Given
        let staff = Staff(
            id: 1,
            email: "test@example.com",
            firstName: "Jane",
            lastName: "Smith",
            avatar: "https://example.com/avatar.jpg"
        )
        
        // Then
        XCTAssertEqual(staff.fullName, "Jane Smith")
    }
    
    // MARK: - LoginRequest Model Tests
    
    func testLoginRequestModel() {
        // Given
        let loginRequest = LoginRequest(
            email: "test@example.com",
            password: "password123"
        )
        
        // Then
        XCTAssertEqual(loginRequest.email, "test@example.com")
        XCTAssertEqual(loginRequest.password, "password123")
    }
    
    // MARK: - LoginResponse Model Tests
    
    func testLoginResponseModel() {
        // Given
        let loginResponse = LoginResponse(token: "test-token-123")
        
        // Then
        XCTAssertEqual(loginResponse.token, "test-token-123")
    }
    
    // MARK: - StaffListResponse Model Tests
    
    func testStaffListResponseModel() {
        // Given
        let staff1 = Staff(
            id: 1,
            email: "test1@example.com",
            firstName: "John",
            lastName: "Doe",
            avatar: "https://example.com/avatar1.jpg"
        )
        
        let staff2 = Staff(
            id: 2,
            email: "test2@example.com",
            firstName: "Jane",
            lastName: "Smith",
            avatar: "https://example.com/avatar2.jpg"
        )
        
        let response = StaffListResponse(
            page: 1,
            perPage: 6,
            total: 12,
            totalPages: 2,
            data: [staff1, staff2]
        )
        
        // Then
        XCTAssertEqual(response.page, 1)
        XCTAssertEqual(response.perPage, 6)
        XCTAssertEqual(response.total, 12)
        XCTAssertEqual(response.totalPages, 2)
        XCTAssertEqual(response.data.count, 2)
        XCTAssertEqual(response.data[0].firstName, "John")
        XCTAssertEqual(response.data[1].firstName, "Jane")
    }
}
