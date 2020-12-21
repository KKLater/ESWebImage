//
//  ImageCache.swift
//  
//
//  Created by 罗树新 on 2020/12/17.
//

import Foundation
import SDWebImage

public struct ImageCache {
    
    static func totalDiskSize() -> UInt {
        return SDImageCache.shared.totalDiskSize()
    }
    
    static func totalDiskSizeDescription() -> String {
        let size = totalDiskSize() / 1024 / 1024
        return "\(size) MB"
    }
    
    static func clearDisk(_ completion: @escaping () -> ()) {
        SDImageCache.shared.clearDisk(onCompletion: completion)
    }
    
    static func clearMemory() {
        SDImageCache.shared.clearMemory()
    }
    
}
