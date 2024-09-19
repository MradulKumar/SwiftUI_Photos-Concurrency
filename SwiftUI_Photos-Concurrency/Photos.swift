//
//  Photos.swift
//  SwiftUI_Photos-Concurrency
//
//  Created by Mradul Kumar on 19/09/24.
//

import Foundation
import SwiftUI

/// An observable object representing a random list of space photos.
@MainActor
class Photos: ObservableObject {
    @Published private(set) var items: [SpacePhoto] = []
    
    /// Updates `items` to a new, random list of `SpacePhoto`.
    func updateItems() async {
        let fetched = await fetchPhotos()
        items = fetched
    }
    
    /// Fetches a new, random list of `SpacePhoto`.
    func fetchPhotos() async -> [SpacePhoto] {
        var downloaded: [SpacePhoto] = []
        let randomPhotoUrls = randomPhotoURLs()
        for url in randomPhotoUrls {
            let photoUrl = URL(string: url)!
            if let photo = await fetchPhoto(from: photoUrl) {
                downloaded.append(photo)
            }
        }
        return downloaded
    }
    
    /// Fetches a `SpacePhoto` from the given `URL`.
    func fetchPhoto(from url: URL) async -> SpacePhoto? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try SpacePhoto(data: data, url: url)
        } catch {
            return nil
        }
    }
    
    func randomPhotoURLs() -> [String] {
        return [
            "https://wallpapers.com/images/featured/space-sjryfre8k8f6i3ge.jpg",
            "https://wallpapers.com/images/high/dark-space-wallpaper-tq8pbg0hsa77cncs.webp",
            "https://wallpapers.com/images/high/dark-space-wallpaper-bt640tbrlew7vri2.webp",
            "https://wallpapers.com/images/high/dark-space-wallpaper-dzhi6u83q8k9szfy.webp",
            "https://wallpapers.com/images/high/dark-space-wallpaper-9dau160mv60p89n5.webp",
            "https://wallpapers.com/images/high/dark-space-wallpaper-nxzf4chsjqjsl82d.webp",
            "https://wallpapers.com/images/high/dark-space-wallpaper-zaqsnn1e4u3mwo4e.webp",
            "https://wallpapers.com/images/high/dark-space-wallpaper-7h5brw4094b65ky5.webp"
        ]
    }
}
