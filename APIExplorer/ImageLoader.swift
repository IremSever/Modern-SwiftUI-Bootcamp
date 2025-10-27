//
//  ImageLoader.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: Image?
    private static let cache = NSCache<NSURL, UIImage>()

    func load(from url: URL?) {
        guard let url else { return }
        if let cached = Self.cache.object(forKey: url as NSURL) {
            self.image = Image(uiImage: cached); return
        }
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let ui = UIImage(data: data) {
                    Self.cache.setObject(ui, forKey: url as NSURL)
                    await MainActor.run { self.image = Image(uiImage: ui) }
                }
            } catch { }
        }
    }
}
