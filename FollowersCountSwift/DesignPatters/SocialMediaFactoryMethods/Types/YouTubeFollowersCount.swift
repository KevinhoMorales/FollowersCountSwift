//
//  YouTubeFollowersCount.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 31/1/25.
//

import Foundation
import GoogleSignIn

final class YouTubeFollowersCount: SocialMedia {
    func fetchFollowers(for network: SocialNetwork, completion: @escaping (SocialNetwork) -> Void) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController, hint: nil, additionalScopes: [Constants.SocialMediaInfo.Youtube.READ_URL]) { signInResult, error in
            if let error = error {
                print("Error al iniciar sesión: \(error.localizedDescription)")
                return
            }
            guard let accessToken = signInResult?.user.accessToken.tokenString else {
                return
            }
            let urlString = Constants.SocialMediaInfo.Youtube.URL
            guard let url = URL(string: urlString) else {
                return
            }
            var request = URLRequest(url: url)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { data, _, _ in
                // Procesar los datos de la respuesta
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let items = json["items"] as? [[String: Any]],
                      let statistics = items.first?["statistics"] as? [String: Any],
                      let subscribers = statistics["subscriberCount"] as? String else {
                    return
                }
                var updatedNetwork = network
                updatedNetwork.followers = Int(subscribers) ?? 0
                
                DispatchQueue.main.async {
                    completion(updatedNetwork)
                }
            }
            task.resume()
        }
    }
}
