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
    @StateObject private var viewModel = WelcomeViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State private var isUserExist = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.backColor)
                        .scaleEffect(isAnimating ? 1.2 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                        .onAppear {
                            isAnimating = true
                            let user =  UserManager.shared.getUser()
                            if !user.uid.isEmpty {
                                isUserExist = true
                                isHomeViewActive = true // Navega directamente a HomeView
                            }
                        }
                    
                    Text("Followlytics te permite agregar tus redes sociales favoritas y mantener un contador total de seguidores. ¡Organiza y gestiona tu presencia en redes sociales de manera sencilla!")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        isLoading = true
                        viewModel.doLoginByLibrary(with: .apple) { user, error in
                            isLoading = false
                            if let _ = user {
                                isHomeViewActive = true
                            } else if let error = error {
                                alertMessage = error.localizedDescription
                                showAlert = true
                            }
                        }
                    }) {
                        HStack {
                            Image("apple_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text("Iniciar sesión con Apple")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.backColor)
                        .foregroundColor(.frontColor)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 16)
                }
                .padding()
                .navigationDestination(isPresented: $isHomeViewActive) {
                    HomeView()
                }
                .navigationTitle("Followlytics")
                .navigationBarTitleDisplayMode(.large)
                .tint(.backColor)
                .alert("Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .frontColor))
                        .scaleEffect(1.5)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
}
