//
//  URLRequest+Extension.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//

import Foundation

extension URLRequest {
    static func createLoginRequest(with url: URL, userName: String, password: String, expiresInMins: Int = 30) -> URLRequest? {
        var request = URLRequest(url: url.appendingPathComponent(Constants.loginAPIURLPath))
        request.httpMethod = "POST"
        request.httpBody = "username=\(userName)&password=\(password)&expiresInMins=\(expiresInMins)".data(using: .utf8)
        return request
    }
    
    static func createProfileRequest(with url: URL, accessToken: String) -> URLRequest? {
        var request = URLRequest(url: url.appendingPathComponent(Constants.profileAPIURLPath))
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(accessToken)", "credentials":"include"]
        return request
    }
}
