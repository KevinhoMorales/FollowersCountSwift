//
//  SettingsView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var showProPlans = false
    @StateObject private var settingsViewModel = SettingsViewModel()
    @State private var showDeleteAccountConfirmation = false
    @State private var navigateToWelcomeView = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Sección "Acerca de"
                VStack(alignment: .leading, spacing: 16) {
                    Text("Acerca de")
                        .font(.headline)
                        .padding(.horizontal, 20)

                    HStack(alignment: .top, spacing: 16) {
                        Image("DevLokosIcon") // Asegúrate de tener esta imagen en tu proyecto
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.backColor)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Desarrollado por DevLokos")
                                .font(.headline)
                            Text("Somos una comunidad que impulsa el aprendizaje en tecnología. Nacimos como un podcast y ahora ofrecemos cursos, tutoriales y mucho más.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color.frontColor)
                .padding(.bottom, 30)

                // Sección para cerrar sesión
                VStack(alignment: .leading, spacing: 16) {
                    Button(action: {
                        settingsViewModel.logout()
                        navigateToWelcomeView = true
                    }) {
                        Text("Cerrar sesión")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color.frontColor)

                Divider()
                    .padding(.vertical, 16)

                // Sección para eliminar cuenta
                VStack(alignment: .leading, spacing: 16) {
                    Button(action: {
                        showDeleteAccountConfirmation = true
                    }) {
                        Text("Eliminar cuenta")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .alert(isPresented: $showDeleteAccountConfirmation) {
                        Alert(
                            title: Text("Eliminar cuenta"),
                            message: Text("¿Estás seguro de que deseas eliminar tu cuenta? Esta acción no se puede deshacer."),
                            primaryButton: .destructive(Text("Eliminar"), action: {
                                settingsViewModel.deleteAccount()
                                navigateToWelcomeView = true
                            }),
                            secondaryButton: .cancel()
                        )
                    }
                }
                .background(Color.frontColor)

                Spacer()
            }
            .background(Color.frontColor)
            .navigationTitle("Configuración")
            .sheet(isPresented: $showProPlans) {
                ProPlansView() // Asegúrate de tener esta vista definida
            }
            .background(
                NavigationLink(
                    destination: WelcomeView(), // Asegúrate de tener esta vista definida
                    isActive: $navigateToWelcomeView,
                    label: { EmptyView() }
                )
            )
        } // End of ScrollView
        .overlay(alignment: .bottom) { // Overlay for version/build info
            VStack(alignment: .center, spacing: 4) {
                Text(settingsViewModel.getVersionAndBuild())
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("© 2025 DevLokos. Todos los derechos reservados.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(Color.frontColor)
        }
    }
}

#Preview {
    SettingsView()
}
