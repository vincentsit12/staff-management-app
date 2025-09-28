//
//  StaffDirectoryViewModelTests.swift
//  scmp-assignmentTests
//
//  Created by Vincent Sit on 28/9/2025.
//

import XCTest
@testable import scmp_assignment

@MainActor
final class StaffDirectoryViewModelTests: XCTestCase {
    
    var viewModel: StaffDirectoryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = StaffDirectoryViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testInitialState() {
        // Then
        XCTAssertTrue(viewModel.staffList.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isLoadingMore)
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMorePages)
    }
    
    // MARK: - State Management Tests
    
    func testClearError() {
        // Given
        viewModel.showError = true
        viewModel.errorMessage = "Test error"
        
        // When
        viewModel.clearError()
        
        // Then
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "")
    }
}
