//
//  Constants.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation

struct Constants {

    static let clearString = ""
    static let appleProfile = "https://firebasestorage.googleapis.com/v0/b/meniuz.appspot.com/o/profiledefault%2Fprofileicon.png?alt=media&token=3fa0bace-b446-47b9-b508-fb84a638200d"
    
    struct Keys {
        static let USER_KEY = "USER_KEY"
    }
    
    struct SocialMediaInfo {
        struct Youtube {
            static let URL = "https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&mine=true"
            static let READ_URL = "https://www.googleapis.com/auth/youtube.readonly"
        }
    }

}
