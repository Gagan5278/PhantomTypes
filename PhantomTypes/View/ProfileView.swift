//
//  ProfileView.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//
import SwiftUI

struct ProfileView: View {
    @Binding var viewModel: SessionViewModel
    @State private var userProfile: Profile?

    var body: some View {
        VStack {
            if let userProfile {
                Text(userProfile.firstName)
                    .padding()
                Text(userProfile.lastName)
                    .padding()
                Text(userProfile.email)
                    .padding()
                Text(userProfile.gender)
                    .padding()
                Divider()
            }
            Button("Fetch Profile") {
                Task {
                    userProfile = await viewModel.fetchUserProfile()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Button("Logout") {
                viewModel.logout()
            }
            .buttonStyle(.bordered)
        }
        .task {
            userProfile = await viewModel.fetchUserProfile()
        }
    }
}
