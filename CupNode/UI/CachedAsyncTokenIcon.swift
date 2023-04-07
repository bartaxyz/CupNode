//
//  CachedAsyncTokenIcon.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: String
    let placeholder: Image
    let cache = NSCache<NSString, UIImage>()
    
    var body: some View {
        AsyncImage(url: URL(string: url), placeholder: {
            ProgressView()
            .frame(width: 40, height: 40) }, content: <#(Image) -> _#>)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 40, height: 40)
        .clipShape(Circle())
        .onDisappear {
            cache.removeAllObjects()
        }
        .onAppear {
            if let image = cache.object(forKey: url as NSString) {
                return
            }
            
            URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    cache.setObject(image, forKey: url as NSString)
                }
            }.resume()
        }
    }
}
