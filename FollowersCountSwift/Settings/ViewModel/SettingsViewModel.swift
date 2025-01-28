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
}


