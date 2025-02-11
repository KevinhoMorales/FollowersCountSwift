//
//  GoogleSignIn.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth

final class GoogleSignIn: SignIn {
    func doLogin(completion: @escaping (Result<User, ServerError>) -> Void) {
//        let config = GIDConfiguration.init(clientID: (FirebaseApp.app()?.options.clientID)!)
//        GIDSignIn.sharedInstance.configuration = config
//        GIDSignIn.sharedInstance.signIn(withPresenting: view()) { googleResult, error in
//            if let error {
//                let serverError = ServerError.badRequest(description: error.localizedDescription)
//                completion(.failure(serverError))
//                return
//            }
//            guard let user = googleResult?.user,
//                  let idToken = user.idToken else { return }
//            let accessToken = user.accessToken
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
//            Auth.auth().signIn(with: credential) { result, error in
//                if let error {
//                    let serverError = ServerError.badRequest(description: error.localizedDescription)
//                    return
//                }
//                // SAVE USER
//                guard let result else { return }
//                guard let profile = user.profile else { return }
//                guard let url = profile.imageURL(withDimension: 200) else {return}
//                let urlString = url.absoluteString
//                let name = profile.name
//                let email = profile.email
//                let uid = result.user.uid
//                let user = User(name: name, profilePicture: urlString, email: email, uid: uid)
//                completion(.success(user))
//            }
//        }
    }
}

import SwiftUI
import Firebase
import GoogleSignIn

struct AuthenticationView: UIViewControllerRepresentable {
    @Binding var isLoggedIn: Bool
    @Binding var errorMessage: String

    func makeUIViewController(context: Context) -> UIViewController {
        let authViewController = AuthViewController()
        authViewController.delegate = context.coordinator
        return authViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AuthViewControllerDelegate {
        let parent: AuthenticationView

        init(_ parent: AuthenticationView) {
            self.parent = parent
        }

        func authenticationSuccessful(user: User) {
            parent.isLoggedIn = true
        }

        func authenticationFailed(error: Error) {
            parent.errorMessage = error.localizedDescription
        }
    }
}

protocol AuthViewControllerDelegate: AnyObject {
    func authenticationSuccessful(user: User)
    func authenticationFailed(error: Error)
}

class AuthViewController: UIViewController {
    weak var delegate: AuthViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { googleUser, error in
            if let error = error as? NSError {
                self.delegate?.authenticationFailed(error: error)
                return
            }
            
            guard let user = googleUser?.user,
                  let idToken = user.idToken else {
                let error = NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error getting user data."])
                self.delegate?.authenticationFailed(error: error)
                return
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, authError in
                if let authError {
                    self.delegate?.authenticationFailed(error: authError)
                    return
                }

                guard let authUser = authResult?.user,
                      let profile = user.profile,
                      let url = profile.imageURL(withDimension: 200) else {
                    let error = NSError(domain: "AuthError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error getting user profile."])
                    self.delegate?.authenticationFailed(error: error)
                    return
                }

                let urlString = url.absoluteString
                let name = profile.name
                let email = profile.email
                let uid = authUser.uid

                let newUser = User(name: name, profilePicture: urlString, email: email, uid: uid)
                self.delegate?.authenticationSuccessful(user: newUser)
            }
        }
    }
}
