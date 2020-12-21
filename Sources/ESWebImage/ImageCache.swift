//
//  ImageCache.swift
//  
//
//  Created by 罗树新 on 2020/12/17.
//

import Foundation
import SDWebImage

public struct ImageCache {
    
    public static func totalDiskSize() -> UInt {
        return SDImageCache.shared.totalDiskSize()
    }
    
    public static func totalDiskSizeDescription() -> String {
        let size = totalDiskSize() / 1024 / 1024
        return "\(size) MB"
    }
    
    public static func clearDisk(_ completion: @escaping () -> ()) {
        SDImageCache.shared.clearDisk(onCompletion: completion)
    }
    
    public static func clearMemory() {
        SDImageCache.shared.clearMemory()
    }
    
}
