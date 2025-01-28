//
//  SettingsView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("theme") private var theme = "system"
    @State private var showProPlans = false // Estado para mostrar la vista de planes PRO
    @StateObject private var settingsViewModel = SettingsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Sección de Apariencia
                VStack(alignment: .leading, spacing: 16) {
                    Text("Apariencia")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    Picker("Tema", selection: $theme) {
                        Text("Claro").tag("light")
                        Text("Oscuro").tag("dark")
                        Text("Sistema").tag("system")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 20)
                }
                .background(Color.frontColor) // Fondo blanco para la sección

                Divider()
                    .padding(.vertical, 16)
                
                // Sección "Versión PRO" mejorada
                VStack(alignment: .leading, spacing: 16) {
                    Text("Versión PRO")
                        .font(.headline)
                        .padding(.horizontal, 20)

                    // Tarjeta de versión PRO
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                                .font(.title2)
                            
                            Text("Desbloquea todas las funciones")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        
                        Text("Accede a características exclusivas, soporte prioritario y más con la versión PRO.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        
                        Button(action: {
                            showProPlans.toggle() // Mostrar la vista de planes PRO
                        }) {
                            HStack {
                                Text("Ver planes de suscripción")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(Color.frontColor.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 20)
                }
                .background(Color.frontColor) // Fondo blanco para la sección

                Divider()
                    .padding(.vertical, 16)

                // Sección "Acerca de"
                VStack(alignment: .leading, spacing: 16) {
                    Text("Acerca de")
                        .font(.headline)
                        .padding(.horizontal, 20)

                    HStack(alignment: .top, spacing: 16) {
                        Image("DevLokosIcon")
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
                .background(Color.frontColor) // Fondo blanco para la sección

                Spacer() // Espacio para empujar el pie de página hacia abajo
            }
        }
        .background(Color.frontColor) // Fondo blanco para toda la vista
        .navigationTitle("Configuración")
        .sheet(isPresented: $showProPlans) {
            ProPlansView() // Vista de planes PRO
        }

        // Pie de página con la versión y copyright
        VStack(alignment: .center, spacing: 4) {
            Text(settingsViewModel.getVersionAndBuild())
                .font(.footnote)
                .foregroundColor(.grayColor) // Color gris para el texto
            Text("© 2025 DevLokos. Todos los derechos reservados.")
                .font(.footnote)
                .foregroundColor(.grayColor) // Color gris para el texto
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20) // Márgenes a los costados
        .padding(.bottom, 20) // Margen inferior
        .background(Color.frontColor) // Fondo blanco para el pie de página
    }
}

#Preview {
    SettingsView()
}
