//
//  AddSocialNetworkViewModel.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation
import SwiftUI

class AddSocialNetworkViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var socialNetworks: [SocialNetwork] = [
        SocialNetwork(name: "Instagram", socialMediaType: .instagram, iconName: "camera.fill", followers: 0),
        SocialNetwork(name: "TikTok", socialMediaType: .tiktok, iconName: "music.note", followers: 0), // TikTok no tiene un ícono oficial en SF Symbols, este es un sustituto
        SocialNetwork(name: "YouTube", socialMediaType: .youtube, iconName: "play.rectangle.fill", followers: 0),
        SocialNetwork(name: "Twitch", socialMediaType: .twitch, iconName: "gamecontroller.fill", followers: 0), // Twitch no tiene un ícono oficial, este es un sustituto relacionado con gaming
        SocialNetwork(name: "X", socialMediaType: .x, iconName: "x.square.fill", followers: 0), // Ícono para X (anteriormente Twitter)
        SocialNetwork(name: "Bluesky", socialMediaType: .bluesky, iconName: "cloud.fill", followers: 0), // Bluesky no tiene un ícono oficial, este es un sustituto
        SocialNetwork(name: "Facebook", socialMediaType: .facebook, iconName: "f.circle.fill", followers: 0), // Ícono para Facebook
        SocialNetwork(name: "LinkedIn", socialMediaType: .linkedin, iconName: "person.crop.square.fill", followers: 0) // LinkedIn no tiene un ícono oficial, este es un sustituto
    ]

    @Published var showAlert: Bool = false
    @Published var selectedNetwork: SocialNetwork? = nil
    @Published var isLoading: Bool = false

    // MARK: - Methods

    // Simula la conexión a la API para obtener seguidores
    func fetchFollowers(for network: SocialNetwork, completion: @escaping (SocialNetwork) -> Void) {
        isLoading = true // Activar el loading
        let socialMediaFactory = SocialMediaFactory.build(socialMediaType: network.socialMediaType)
        
        // Llamar a la fábrica para obtener los seguidores
        socialMediaFactory.fetchFollowers(for: network) { updatedNetwork in
            self.isLoading = false // Desactivar el loading
            completion(updatedNetwork) // Pasar la red social actualizada al completion handler
        }
    }

    // Función para confirmar la adición de la red social
    func confirmAddNetwork(completion: @escaping (SocialNetwork) -> Void) {
        if let network = selectedNetwork {
            fetchFollowers(for: network) { updatedNetwork in
                completion(updatedNetwork) // Devuelve la red social actualizada
            }
        }
    }
}
