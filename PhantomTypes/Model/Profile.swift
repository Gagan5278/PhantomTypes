//
//  Profile.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//
import Foundation

struct Profile: Codable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender, email, image: String
}
