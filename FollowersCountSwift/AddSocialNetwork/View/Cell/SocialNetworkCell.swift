//
//  SocialNetworkCell.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 31/1/25.
//

import SwiftUI

struct SocialNetworkCell: View {
    let network: SocialNetwork
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                // Icono de la red social
                Image(systemName: network.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.backColor) // Usamos .backColor (asegúrate de que esté definido en tus assets)
                    .clipShape(Circle())

                // Nombre de la red social
                Text(network.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.leading, 10)

                Spacer()

                // Icono de "agregar"
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color(.systemBackground)) // Fondo de la celda
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle()) // Elimina el estilo por defecto del botón
    }
}
