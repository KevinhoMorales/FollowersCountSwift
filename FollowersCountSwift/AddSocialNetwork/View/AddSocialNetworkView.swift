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
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.socialNetworks) { network in
                        SocialNetworkCell(
                            network: network,
                            isAdded: homeViewModel.socialNetworks.contains { $0.name == network.name } // Verifica si ya está agregada
                        ) {
                            viewModel.selectedNetwork = network
                            viewModel.showAlert = true
                        }
                        .padding(.horizontal, 16)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Agregar Red Social")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Agregar Red Social", isPresented: $viewModel.showAlert) {
                    Button("Cancelar", role: .cancel) {
                        viewModel.selectedNetwork = nil
                    }
                    Button("Agregar", role: .none) {
                        if let _ = viewModel.selectedNetwork {
                            viewModel.confirmAddNetwork { updatedNetwork in
                                homeViewModel.validateAndAddSocialNetwork(updatedNetwork) // Usa validateAndAddSocialNetwork
                                dismiss()
                            }
                        }
                    }
                } message: {
                    if let network = viewModel.selectedNetwork {
                        Text("¿Estás seguro de que quieres agregar \(network.name)?")
                    }
                }

                // Mostrar el indicador de carga
                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .frontColor))
                                .scaleEffect(1.5)
                        )
                }
            }
        }
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
