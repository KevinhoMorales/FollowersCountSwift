//
//  YouTubeFollowersCount.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 31/1/25.
//

import Foundation

final class YouTubeFollowersCount: SocialMedia {
    func fetchFollowers(for network: SocialNetwork, completion: @escaping (SocialNetwork) -> Void) {
        let channelID = Constants.APIKeys.Youtube.CHANNEL_ID
        let apiKey = Constants.APIKeys.Youtube.YOUR_API_KEY_HERE
        let urlString = "https://www.googleapis.com/youtube/v3/channels?part=statistics&id=\(channelID)&key=\(apiKey)"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let items = json["items"] as? [[String: Any]],
                           let statistics = items.first?["statistics"] as? [String: Any],
                           let subscribers = statistics["subscriberCount"] as? String {
                            var updatedNetwork = network
                            updatedNetwork.followers = Int(subscribers) ?? 0
                            DispatchQueue.main.async {
                                completion(updatedNetwork)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}



