//
//  URLResponse+Extension.swift
//  PhantomTypes
//
//  Created by Gagan Vishal Mishra on 10.12.24.
//
import Foundation

extension URLResponse {
    func validdateRerponse() throws {
        guard let httpResponse = self as? HTTPURLResponse, 2..<300 ~= httpResponse.statusCode  else {
            throw CustomError.invalidRequest
        }
    }
}
