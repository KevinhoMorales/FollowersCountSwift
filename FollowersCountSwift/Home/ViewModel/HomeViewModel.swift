//
//  HomeViewModel.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var socialNetworks: [SocialNetwork] = []
    @Published var showAddSocialNetworkView: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Computed Properties
    var totalFollowers: Int {
        socialNetworks.reduce(0) { $0 + $1.followers }
    }
    
    // MARK: - Methods
    
    // Agregar una red social
    func addSocialNetwork(_ network: SocialNetwork) {
        socialNetworks.append(network)
    }
    
    // Eliminar una red social
    func removeSocialNetwork(_ network: SocialNetwork) {
        if let index = socialNetworks.firstIndex(where: { $0.id == network.id }) {
            socialNetworks.remove(at: index)
        }
    }
    
    // Validar y agregar una red social (opcional)
    func validateAndAddSocialNetwork(_ network: SocialNetwork) {
        if socialNetworks.contains(where: { $0.name == network.name }) {
            errorMessage = "Esta red social ya ha sido agregada."
        } else {
            addSocialNetwork(network)
            errorMessage = nil
        }
    }
}
