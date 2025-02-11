//
//  WelcomeViewModel.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation
import Firebase
import GoogleSignIn
import AuthenticationServices

final class WelcomeViewModel: ObservableObject {
    
    func doLoginByLibrary(with signInType: SignInType, completion: @escaping(User?, ServerError?) -> ()) {
        let signInFactory = SignInFactory.build(signInType: signInType)
        signInFactory.doLogin() { result in
            switch result {
            case .success(let user):
                ObjectManager.shared.saveObjt(objt: user, key: Constants.Keys.USER_KEY)
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
