//
//  User.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import UIKit

struct User: Codable {
    var name = Constants.clearString
    var profilePicture = Constants.clearString
    var email = Constants.clearString
    var uid = Constants.clearString
    
    mutating func userEmpty() -> Bool {
        if name.isEmpty && profilePicture.isEmpty && email.isEmpty {
            return true
        }
        return false
    }
}

enum ServerError: LocalizedError {
    case badRequest(description: String)
    var errorDescription: String {
        switch self {
        case .badRequest(let description):
            return description
        }
    }
}
