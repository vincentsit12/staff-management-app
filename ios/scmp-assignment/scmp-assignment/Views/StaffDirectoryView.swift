//
//  StaffDirectoryView.swift
//  scmp-assignment
//
//  Created by Vincent Sit on 28/9/2025.
//

import SwiftUI

struct StaffDirectoryView: View {
    let loginToken: String
    
    var body: some View {
        VStack {
            Text("Staff List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Login token: \(loginToken)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
            
            Text("Staff Directory will be implemented next")
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StaffDirectoryView(loginToken: "sample_token")
}
