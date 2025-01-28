//
//  Bundle+Extension.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 27/1/25.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    var buildVersionNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
}
