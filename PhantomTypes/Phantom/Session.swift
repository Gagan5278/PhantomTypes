//
//  Session.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//

import Foundation

struct Session<State> {
    let user: User?
    let apiBaseURL: URL
    
    private init(user: User?, apiBaseURL: URL) {
        self.user = user
        self.apiBaseURL = apiBaseURL
    }
    
    //MARK: - Factory method for an unauthorized session
    static func unauthenticated(apiBaseURL: URL) -> Session<Unauthorized> {
        Session<Unauthorized>(
            user: nil,
            apiBaseURL: apiBaseURL
        )
    }
}

// MARK: - Unauthorized State
extension Session where State == Unauthorized {
    func login(username: String, password: String) async throws  -> Session<Authorized> {
        guard let request = URLRequest.createLoginRequest(with: apiBaseURL, userName: username, password: password) else {
            throw CustomError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try response.validdateRerponse()
        
        do {
            let model = try JSONDecoder().decode(User.self, from: data)
            return Session<Authorized>(user: model, apiBaseURL: apiBaseURL)
        } catch {
            throw CustomError.invalidOutput
        }
    }
}

// MARK: - Authorized State
extension Session  where State == Authorized {
    func fetchUserProfileFrom(accessToken: String)  async throws  ->  Profile? {
        guard let request = URLRequest.createProfileRequest(with: apiBaseURL, accessToken: accessToken) else {
            throw CustomError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try response.validdateRerponse()
        
        do {
            return try JSONDecoder().decode(Profile.self, from: data)
        } catch {
            throw CustomError.invalidOutput
        }
    }
    
    func logout() -> Session<Unauthorized> {
        print("Do Logging out here...")
        return Session<Unauthorized>(user: nil, apiBaseURL: apiBaseURL)
    }
}
