//
//  LoginViewModel.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var loginToken: String = ""
    @Published var isLoggedIn: Bool = false
    
    private let networkService = NetworkService.shared
    
    var isFormValid: Bool {
        return isValidEmail(email) && isValidPassword(password)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // Constraint: letter and number only, 6-10 characters
        let passwordRegex = "^[a-zA-Z0-9]{6,10}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func login() async {
        guard isFormValid else {
            errorMessage = "Please enter valid email and password (6-10 characters, letters and numbers only)"
            showError = true
            return
        }
        
        isLoading = true
        errorMessage = ""
        showError = false
        
        do {
            let response = try await networkService.login(email: email, password: password)
            loginToken = response.token
            isLoggedIn = true
        } catch {
            handleLoginError(error)
        }
        
        isLoading = false
    }
    
    private func handleLoginError(_ error: Error) {
        switch error {
        case NetworkError.serverError(let statusCode):
            if statusCode == 400 {
                errorMessage = "Invalid credentials"
            } else {
                errorMessage = "Server error: \(statusCode)"
            }
        case NetworkError.decodingError:
            errorMessage = "Invalid response format"
        case NetworkError.invalidURL:
            errorMessage = "Invalid URL"
        case NetworkError.noData:
            errorMessage = "No data received"
        default:
            errorMessage = "Login failed. Please try again."
        }
        showError = true
    }
    
    func clearError() {
        showError = false
        errorMessage = ""
    }
}
