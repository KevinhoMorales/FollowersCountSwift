//
//  SocialMedia.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 31/1/25.
//

import Foundation

protocol SocialMedia {
    func fetchFollowers(for network: SocialNetwork, completion: @escaping (SocialNetwork) -> Void)
}
