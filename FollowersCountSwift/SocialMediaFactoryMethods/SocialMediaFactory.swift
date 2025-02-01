//
//  SocialMediaFactory.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 31/1/25.
//

import Foundation

final class SocialMediaFactory {
    static func build(socialMediaType: SocialMediaType) -> SocialMedia {
        switch socialMediaType {
        case .instagram:
            return InstagramFollowersCount()
        case .tiktok:
            return TikTokFollowersCount()
        case .youtube:
            return YouTubeFollowersCount()
        }
    }
}
