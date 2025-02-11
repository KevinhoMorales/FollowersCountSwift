//
//  TikTokFollowersCount.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 31/1/25.
//

import Foundation

final class TikTokFollowersCount: SocialMedia {
    func fetchFollowers(for network: SocialNetwork, completion: @escaping (SocialNetwork) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            var updatedNetwork = network
            updatedNetwork.followers = Int.random(in: 1000...10000) // Datos simulados
            DispatchQueue.main.async {
                completion(updatedNetwork) // Notificar que la operación ha finalizado
            }
        }
    }
}
