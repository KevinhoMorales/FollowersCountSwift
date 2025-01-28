//
//  AddSocialNetworkView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import SwiftUI

struct AddSocialNetworkView: View {
    @ObservedObject var viewModel: AddSocialNetworkViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        List(viewModel.socialNetworks) { network in
            Button(action: {
                // Simular la conexión a la API y obtener seguidores
                viewModel.fetchFollowers(for: network) { updatedNetwork in
                    homeViewModel.addSocialNetwork(updatedNetwork)
                    dismiss() // Cierra la vista después de agregar la red social
                }
            }) {
                HStack {
                    Image(systemName: network.iconName)
                        .foregroundColor(.backColor)
                    Text(network.name)
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Agregar Red Social")
    }
}

// Previsualización de la vista
#Preview {
    let addSocialNetworkViewModel = AddSocialNetworkViewModel()
    let homeViewModel = HomeViewModel()
    
    return AddSocialNetworkView(
        viewModel: addSocialNetworkViewModel,
        homeViewModel: homeViewModel
    )
}
