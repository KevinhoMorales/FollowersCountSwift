//
//  SignIn.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation

protocol SignIn {
    func doLogin(completion: @escaping(Result<User, ServerError>) -> ())
}
