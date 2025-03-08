//
//  HomeView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var addSocialNetworkViewModel = AddSocialNetworkViewModel()

    var body: some View {
        VStack {
            if homeViewModel.socialNetworks.isEmpty {
                EmptySocialNetworksView()
            } else {
                SocialNetworksListView(homeViewModel: homeViewModel)
            }
            AddSocialNetworkButton(homeViewModel: homeViewModel)
        }
        .navigationTitle("Redes Sociales")
        .navigationBarTitleDisplayMode(.large) // Título grande
        .toolbar {
            ToolbarItem(placement: .automatic) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.backColor)
                }
            }
        }
        .sheet(isPresented: $homeViewModel.showAddSocialNetworkView) {
            AddSocialNetworkView(viewModel: addSocialNetworkViewModel, homeViewModel: homeViewModel)
        }
        .alert("Error", isPresented: .constant(homeViewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) {
                homeViewModel.errorMessage = nil
            }
        }, message: {
            Text(homeViewModel.errorMessage ?? "")
        })
        .navigationBarBackButtonHidden(true)
    }
}

// Subvista para cuando no hay redes sociales
struct EmptySocialNetworksView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.line.dotted.person")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)
                .foregroundColor(.backColor)
                .padding()
            Text("Agrega tu red social favorita")
                .font(.title2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Subvista para la lista de redes sociales
struct SocialNetworksListView: View {
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        List {
            ForEach(homeViewModel.socialNetworks) { network in
                SocialNetworkCard(network: network)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            homeViewModel.removeSocialNetwork(network)
                        } label: {
                            Label("Eliminar", systemImage: "trash.fill")
                        }
                    }
            }

            // Sección de total de seguidores
            HStack {
                Text("TOTAL") // "TOTAL" en mayúsculas
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(homeViewModel.totalFollowers) seguidores") // Agrega "seguidores" al número
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.backColor)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.grayColor.opacity(0.1))
            .cornerRadius(12)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 8)
        }
        .listStyle(PlainListStyle())
        .padding(.horizontal, 16)
    }
}

// Subvista para el botón de agregar red social
struct AddSocialNetworkButton: View {
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        Button(action: {
            homeViewModel.showAddSocialNetworkView = true
        }) {
            Image(systemName: "plus")
                .font(.title)
                .padding()
                .background(Color.backColor)
                .foregroundColor(.frontColor)
                .clipShape(Circle())
        }
        .padding()
    }
}

// Previsualización de la vista
#Preview {
    HomeView()
}
