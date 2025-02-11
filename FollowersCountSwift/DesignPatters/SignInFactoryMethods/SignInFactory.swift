//
//  SignInFactory.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation

final class SignInFactory {
    static func build(signInType: SignInType) -> SignIn {
        switch signInType {
        case .google:
            return GoogleSignIn()
        case .apple:
            return AppleSignIn()
        }
    }
}
