//
//  ImageUtils.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

func getOptimalNFTPreview(previews: [NXYZNFTTypes.Preview]?, size: Int) -> String? {
    if let previews = previews {
        // Sort the previews by the difference between the preview's width/height and the desired size
        let sortedPreviews = previews.sorted { preview1, preview2 in
            let diff1 = abs((preview1.width ?? 0) - size)
            let diff2 = abs((preview2.width ?? 0) - size)
            return diff1 < diff2
        }
        
        // Find the first preview whose width or height is at least as large as the desired size
        if let preview = sortedPreviews.first(where: { preview in
            let previewWidth = preview.width ?? 0
            let previewHeight = preview.height ?? 0
            return previewWidth >= size || previewHeight >= size
        }) {
            return preview.URI
        }
        
        // If no preview is large enough, return the URI of the largest preview
        if let largestPreview = previews.max(by: { preview1, preview2 in
            (preview1.width ?? 0) * (preview1.height ?? 0) < (preview2.width ?? 0) * (preview2.height ?? 0)
        }) {
            return largestPreview.URI
        }
    }
    
    // If there are no previews, return nil
    return nil
}
