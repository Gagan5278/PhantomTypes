//
//  SessionViewModel.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//

import Foundation

@Observable
class SessionViewModel {
    var unauthorizedSession: Session<Unauthorized>?
    var authorizedSession: Session<Authorized>?
    
    init(baseURL: String = Constants.baseAPIURL) {
        guard let apiBaseURL = URL(string: baseURL) else {
            return
        }
        unauthorizedSession = Session<Unauthorized>.unauthenticated(apiBaseURL: apiBaseURL)
    }
    
    @MainActor
    func login(username: String, password: String) async  {
        if let unauthorizedSession = unauthorizedSession {
            do {
                authorizedSession = try await unauthorizedSession.login(username: username, password: password)
                self.unauthorizedSession = nil
            } catch {
                // Handle Error here/Show alert
            }
        }
    }
    
    func logout() {
        if let authorizedSession = authorizedSession {
            unauthorizedSession = authorizedSession.logout()
            self.authorizedSession = nil
        }
    }
    
    @MainActor
    func fetchUserProfile() async -> Profile? {
        guard let authorizedSession = authorizedSession, let accessToken = authorizedSession.user?.accessToken else { return nil }
        
        do {
            let profile = try await authorizedSession.fetchUserProfileFrom(accessToken: accessToken)
            self.unauthorizedSession = nil
            return profile
        } catch {
            // Handle Error here/Show alert
            return nil
        }
    }
}
