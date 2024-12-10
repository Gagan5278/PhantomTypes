//
//  LoginView.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//
import SwiftUI

struct LoginView: View {
    @Binding var viewModel: SessionViewModel
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                Task {
                    await viewModel.login(username: username, password: password)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}
