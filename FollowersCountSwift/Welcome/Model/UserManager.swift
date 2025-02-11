//
//  UserManager.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation

final class UserManager {
    static let shared: UserManager = {
        UserManager()
    }()
    
    func getUser() -> User {
        let user: User? = ObjectManager.shared.getObjt(key: Constants.Keys.USER_KEY)
        guard let res = user else { return User(name: Constants.clearString,
                                                profilePicture: Constants.clearString,
                                                email: Constants.clearString,
                                                uid: Constants.clearString) }
        return res
    }
}
