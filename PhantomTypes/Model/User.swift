//
//  User.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//
import Foundation

struct User: Codable {
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
    let accessToken, refreshToken: String
}
