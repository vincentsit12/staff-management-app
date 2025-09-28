//
//  StaffDirectoryView.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import SwiftUI

struct StaffDirectoryView: View {
    let loginToken: String
    @StateObject private var viewModel = StaffDirectoryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Login token display
            HStack {
                Text("Login token: \(loginToken)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            // Staff list
            if viewModel.isLoading && viewModel.staffList.isEmpty {
                VStack {
                    Spacer()
                    ProgressView("Loading staff...")
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
            } else {
                List {
                    ForEach(viewModel.staffList) { staff in
                        StaffRowView(staff: staff)
                            .onAppear {
                                // Load more when reaching the last item
                                if staff.id == viewModel.staffList.last?.id {
                                    Task {
                                        await viewModel.loadMoreStaff()
                                    }
                                }
                            }
                    }
                    
                    // Load more button
                    if viewModel.hasMorePages {
                        HStack {
                            Spacer()
                            if viewModel.isLoadingMore {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(0.8)
                                Text("Loading more...")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } else {
                                Button("Load More") {
                                    Task {
                                        await viewModel.loadMoreStaff()
                                    }
                                }
                                .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        .padding()
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Staff List")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadInitialData()
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK") {
                viewModel.clearError()
            }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct StaffRowView: View {
    let staff: Staff
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            AsyncImage(url: URL(string: staff.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            // Staff info
            VStack(alignment: .leading, spacing: 4) {
                Text(staff.fullName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(staff.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        StaffDirectoryView(loginToken: "sample_token")
    }
}
