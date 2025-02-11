//
//  AppleSignIn.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation
import CryptoKit
import AuthenticationServices
import FirebaseAuth

final class AppleSignIn: SignIn {
    func doLogin(completion: @escaping(Result<User, ServerError>) -> ()) {
        AppleSignInService.shared.continueWithApple(completion: completion)
    }
}

protocol AppleSignInProtocol {
    func appleSignInAction(result: Result<User, ServerError>)
}

final class AppleSignInService: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    static let shared: AppleSignInService = {
        return AppleSignInService()
    }()
    
    private var currentNonce: String? = Constants.clearString
    private let deviceView: UIView? = UIView()
    private var completion: ((Result<User, ServerError>) -> ())?
    
    func continueWithApple(completion: @escaping (Result<User, ServerError>) -> ()) {
        self.completion = completion
        currentNonce = randomNonceString()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(currentNonce!)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let serverError = ServerError.badRequest(description: error.localizedDescription)
        completion?(.failure(serverError))
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        (deviceView?.window!)!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let nonce = currentNonce, let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential, let appleIDToken = appleIDCredential.identityToken, let appleIDTokenString = String(data: appleIDToken, encoding: .utf8) {
            let providerID = AuthProviderID.apple
            let credential = OAuthProvider.credential(providerID: providerID, idToken: appleIDTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: credential) { [self] (result, error) in
                if let error {
                    let serverError = ServerError.badRequest(description: error.localizedDescription)
                    completion?(.failure(serverError))
                    return
                }
                if let result {
                    let urlString = Constants.appleProfile
                    let name = "Apple"
                    guard let email = result.user.email else { return }
                    let uid = result.user.uid
                    let user = User(name: name, profilePicture: urlString, email: email, uid: uid)
                    completion?(.success(user))
                }
            }
        }
        
    }
}

