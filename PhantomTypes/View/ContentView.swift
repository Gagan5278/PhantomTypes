//
//  ContentView.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel = SessionViewModel(baseURL: Constants.baseAPIURL)
    
    var body: some View {
        Group {
            if let _ = viewModel.authorizedSession {
                ProfileView(viewModel: $viewModel)
            } else {
                LoginView(viewModel: $viewModel)
            }
        }
    }
}
