//
//  StaffDirectoryViewModel.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import Foundation
import SwiftUI

@MainActor
class StaffDirectoryViewModel: ObservableObject {
    @Published var staffList: [Staff] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var currentPage: Int = 1
    @Published var hasMorePages: Bool = true
    
    private let networkService = NetworkService.shared
    
    func loadInitialData() async {
        currentPage = 1
        staffList = []
        hasMorePages = true
        await loadStaffList()
    }
    
    func refreshData() async {
        currentPage = 1
        staffList = []
        hasMorePages = true
        await loadStaffList()
    }
    
    func loadMoreStaff() async {
        guard !isLoadingMore && !isLoading && hasMorePages else { return }
        
        // Small delay to prevent too rapid loading
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
        
        await loadStaffList()
    }
    
    private func loadStaffList() async {
        if currentPage == 1 {
            isLoading = true
        } else {
            isLoadingMore = true
        }
        
        errorMessage = ""
        showError = false
        
        do {
            let response = try await networkService.fetchStaffList(page: currentPage)
            
            if currentPage == 1 {
                staffList = response.data
            } else {
                staffList.append(contentsOf: response.data)
            }
            
            hasMorePages = currentPage < response.totalPages
            currentPage += 1
            
        } catch {
            handleError(error)
        }
        
        isLoading = false
        isLoadingMore = false
    }
    
    private func handleError(_ error: Error) {
        switch error {
        case NetworkError.serverError(let statusCode):
            errorMessage = "Server error: \(statusCode)"
        case NetworkError.decodingError:
            errorMessage = "Invalid response format"
        case NetworkError.invalidURL:
            errorMessage = "Invalid URL"
        case NetworkError.noData:
            errorMessage = "No data received"
        default:
            errorMessage = "Failed to load staff list. Please try again."
        }
        showError = true
    }
    
    func clearError() {
        showError = false
        errorMessage = ""
    }
}