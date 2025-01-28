//
//  WelcomeView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isHomeViewActive = false
    @State private var isAnimating = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Imagen grande con animación
                Image(systemName: "person.3.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.backColor)
                    .scaleEffect(isAnimating ? 1.2 : 1.0) // Escala la imagen
                    .animation(
                        .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                    .onAppear {
                        isAnimating = true // Inicia la animación
                    }

                // Descripción de la aplicación
                Text("Follount te permite agregar tus redes sociales favoritas y mantener un contador total de seguidores. ¡Organiza y gestiona tu presencia en redes sociales de manera sencilla!")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                Spacer() // Espacio para empujar el botón hacia abajo

                // Botón para iniciar
                Button(action: {
                    isHomeViewActive = true
                }) {
                    Text("Iniciar")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.backColor)
                        .foregroundColor(.frontColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16) // Márgenes a los costados
                .padding(.bottom, 20) // Margen inferior
            }
            .padding() // Padding general
            .navigationDestination(isPresented: $isHomeViewActive) {
                HomeView()
            }
            .navigationTitle("¡Bienvenido a Follount!") // Título en la barra de navegación
            .navigationBarTitleDisplayMode(.large) // Título grande (largeTitle)
            .tint(.backColor) // Cambia el color del chevron y otros elementos de la barra de navegación
        }
    }
}

#Preview {
    WelcomeView()
}
