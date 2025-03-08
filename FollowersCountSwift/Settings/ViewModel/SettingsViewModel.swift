//
//  SettingsViewModel.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var versionAndBuild = 0
    
    // Obtener version y build
    func getVersionAndBuild() -> String {
        "v\(Bundle.main.releaseVersionNumber) - Build \(Bundle.main.buildVersionNumber)"
    }
    
    // Método para cerrar sesión
    func logout() {
        // Aquí va la lógica para cerrar sesión
        ObjectManager.shared.removeObjt(key: Constants.Keys.USER_KEY)
        print("Sesión cerrada")
    }
    
    // Método para eliminar la cuenta
    func deleteAccount() {
        // Aquí va la lógica para eliminar la cuenta
        ObjectManager.shared.removeObjt(key: Constants.Keys.USER_KEY)
        print("Cuenta eliminada")
    }
}


