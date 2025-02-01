//
//  SocialNetworkCard.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import SwiftUI

struct SocialNetworkCard: View {
    let network: SocialNetwork

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                // Icono de la red social
                Image(systemName: network.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.backColor)

                // Nombre de la red social
                Text(network.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                // Número de seguidores
                Text("\(network.followers) seguidores")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(height: 60) // Hacemos la celda más alta
            .background(Color.frontColor)
            .cornerRadius(10)
        }
        .listRowInsets(EdgeInsets()) // Elimina el padding por defecto
    }
}

// Previsualización de la vista
#Preview {
    SocialNetworkCard(network: SocialNetwork(name: "Instagram", socialMediaType: .instagram, iconName: "camera.fill", followers: 15000))
        .previewLayout(.sizeThatFits)
        .padding()
}
