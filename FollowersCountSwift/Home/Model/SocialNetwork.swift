//
//  SocialNetwork.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation

struct SocialNetwork: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    var followers: Int
}
