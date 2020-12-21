
//
//  ImageCache.swift
//
//
//  Created by 罗树新 on 2020/12/17.
//

import Foundation
import SDWebImage

public struct NeedLoadImage {
    var imageUrlString: String
    var placeholder: UIImage?
    var loadMode: ImageLoader.Mode
    var progress: ImageLoader.RRCImageLoaderProgressBlock?
    var completed: RRCExternalCompletionBlock?
    var handler: (UIImageView, NeedLoadImage) -> String?
}

public struct ImageLoader {
    
    /// 网络图片加载方式
    ///
    ///     lazy：意味着在控件宽高有一个为 0 的时候，均做标记，等待控件 layoutSubview 结束后，宽高均不为 0，加载图片
    ///     force：意味着在控件宽高有一个为 0  的时候，强制控件（包含父控件）做 layoutSubviews 操作，并发起加载图片
    ///     forceLazy：不受控件宽高影响，均在控件 layoutSubviews 后根据宽高发起加载网络图片
    ///     origin：在控件宽高不为0时，可以根据 handle 处理图片链接；控件宽高为0时，强制按照原图片链接加载图片
    public enum Mode {
        case lazy
        case force
        case forceLazy
        case origin
    }
    
    public typealias RRCWebImageOptions = SDWebImageOptions
    public typealias RRCImageLoaderProgressBlock = SDImageLoaderProgressBlock
    public typealias RRCInternalCompletionBlock = SDInternalCompletionBlock
    
    public static func loadImage(with url: URL?, options: RRCWebImageOptions, progress: RRCImageLoaderProgressBlock? = nil, completed: RRCInternalCompletionBlock? = nil) {
        if let com = completed {
            SDWebImageManager.shared.loadImage(with: url, options: options, progress: progress, completed: com)
        } else {
            SDWebImageManager.shared.loadImage(with: url, options: options, progress: progress) { (image, data, error, type, finish, url) in }
        }
    }
}
