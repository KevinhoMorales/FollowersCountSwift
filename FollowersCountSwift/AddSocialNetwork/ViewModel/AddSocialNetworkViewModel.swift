//
//  AddSocialNetworkViewModel.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation

class AddSocialNetworkViewModel: ObservableObject {
    @Published var socialNetworks: [SocialNetwork] = [
        SocialNetwork(name: "Instagram", iconName: "camera.fill", followers: 0),
        SocialNetwork(name: "Twitter", iconName: "bird.fill", followers: 0),
        SocialNetwork(name: "Facebook", iconName: "f.circle.fill", followers: 0),
        SocialNetwork(name: "LinkedIn", iconName: "linkedinlogo", followers: 0),
        SocialNetwork(name: "YouTube", iconName: "play.rectangle.fill", followers: 0),
        SocialNetwork(name: "TikTok", iconName: "t.square.fill", followers: 0),
        SocialNetwork(name: "Twitch", iconName: "twitchlogo", followers: 0),
        SocialNetwork(name: "X", iconName: "x.square.fill", followers: 0),
    ]

    // Simula la conexión a la API para obtener seguidores
    func fetchFollowers(for network: SocialNetwork, completion: @escaping (SocialNetwork) -> Void) {
        // Simulación de una llamada a la API
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            var updatedNetwork = network
            updatedNetwork.followers = Int.random(in: 1000...10000) // Datos simulados
            DispatchQueue.main.async {
                completion(updatedNetwork)
            }
        }
    }
}
