//
//  GoogleSignInView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 7/3/25.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInView: UIViewControllerRepresentable {
    @Binding var accessToken: String?
    @Binding var errorMessage: String?

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No es necesario implementar nada aquí
    }
}
