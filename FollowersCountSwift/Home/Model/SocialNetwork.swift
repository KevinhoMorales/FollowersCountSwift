//
//  SocialNetwork.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation

struct SocialNetwork: Identifiable, Equatable {
    let id = UUID() // Identificador único
    let name: String
    let socialMediaType: SocialMediaType
    let iconName: String
    var followers: Int

    // Implementación de Equatable
    static func == (lhs: SocialNetwork, rhs: SocialNetwork) -> Bool {
        return lhs.name == rhs.name
    }
}
