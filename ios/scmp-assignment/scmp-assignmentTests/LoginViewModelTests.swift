//
//  LoginViewModelTests.swift
//  scmp-assignmentTests
//
//  Created by Vincent Sit on 28/9/2025.
//

import XCTest
@testable import scmp_assignment

@MainActor
final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Email Validation Tests
    
    func testValidEmailValidation() {
        // Given
        let validEmail = "test@example.com"
        
        // When
        let isValid = viewModel.isValidEmail(validEmail)
        
        // Then
        XCTAssertTrue(isValid, "Valid email should pass validation")
    }
    
    func testInvalidEmailValidation() {
        // Given
        let invalidEmail = "invalid-email"
        
        // When
        let isValid = viewModel.isValidEmail(invalidEmail)
        
        // Then
        XCTAssertFalse(isValid, "Invalid email should fail validation")
    }
    
    func testEmptyEmailValidation() {
        // Given
        let emptyEmail = ""
        
        // When
        let isValid = viewModel.isValidEmail(emptyEmail)
        
        // Then
        XCTAssertFalse(isValid, "Empty email should fail validation")
    }
    
    func testEmailWithoutAtSymbol() {
        // Given
        let emailWithoutAt = "testexample.com"
        
        // When
        let isValid = viewModel.isValidEmail(emailWithoutAt)
        
        // Then
        XCTAssertFalse(isValid, "Email without @ should fail validation")
    }
    
    // MARK: - Password Validation Tests
    
    func testValidPasswordValidation() {
        // Given
        let validPassword = "valid123"
        
        // When
        let isValid = viewModel.isValidPassword(validPassword)
        
        // Then
        XCTAssertTrue(isValid, "Valid password should pass validation")
    }
    
    func testInvalidPasswordTooShort() {
        // Given
        let shortPassword = "12345" // Too short
        
        // When
        let isValid = viewModel.isValidPassword(shortPassword)
        
        // Then
        XCTAssertFalse(isValid, "Password too short should fail validation")
    }
    
    func testInvalidPasswordTooLong() {
        // Given
        let longPassword = "12345678901" // Too long
        
        // When
        let isValid = viewModel.isValidPassword(longPassword)
        
        // Then
        XCTAssertFalse(isValid, "Password too long should fail validation")
    }
    
    func testInvalidPasswordWithSpecialCharacters() {
        // Given
        let passwordWithSpecial = "valid@123" // Contains special character
        
        // When
        let isValid = viewModel.isValidPassword(passwordWithSpecial)
        
        // Then
        XCTAssertFalse(isValid, "Password with special characters should fail validation")
    }
    
    func testPasswordWithOnlyLetters() {
        // Given
        let lettersOnly = "password"
        
        // When
        let isValid = viewModel.isValidPassword(lettersOnly)
        
        // Then
        XCTAssertTrue(isValid, "Password with only letters should pass validation")
    }
    
    func testPasswordWithOnlyNumbers() {
        // Given
        let numbersOnly = "123456"
        
        // When
        let isValid = viewModel.isValidPassword(numbersOnly)
        
        // Then
        XCTAssertTrue(isValid, "Password with only numbers should pass validation")
    }
    
    func testEmptyPasswordValidation() {
        // Given
        let emptyPassword = ""
        
        // When
        let isValid = viewModel.isValidPassword(emptyPassword)
        
        // Then
        XCTAssertFalse(isValid, "Empty password should fail validation")
    }
    
    // MARK: - Form Validation Tests
    
    func testFormValidWithValidInputs() {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "valid123"
        
        // When
        let isValid = viewModel.isFormValid
        
        // Then
        XCTAssertTrue(isValid, "Form should be valid with valid email and password")
    }
    
    func testFormInvalidWithInvalidEmail() {
        // Given
        viewModel.email = "invalid-email"
        viewModel.password = "valid123"
        
        // When
        let isValid = viewModel.isFormValid
        
        // Then
        XCTAssertFalse(isValid, "Form should be invalid with invalid email")
    }
    
    func testFormInvalidWithInvalidPassword() {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "12345" // Too short
        
        // When
        let isValid = viewModel.isFormValid
        
        // Then
        XCTAssertFalse(isValid, "Form should be invalid with invalid password")
    }
    
    // MARK: - State Management Tests
    
    func testInitialState() {
        // Then
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.loginToken, "")
        XCTAssertFalse(viewModel.isLoggedIn)
    }
    
    func testResetLoginState() {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.isLoading = true
        viewModel.showError = true
        viewModel.errorMessage = "Test error"
        viewModel.loginToken = "test-token"
        viewModel.isLoggedIn = true
        
        // When
        viewModel.resetLoginState()
        
        // Then
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.loginToken, "")
        XCTAssertFalse(viewModel.isLoggedIn)
    }
    
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
