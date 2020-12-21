//
//  ImageExtension.swift
//  
//
//  Created by 罗树新 on 2020/12/17.
//

import Foundation
import UIKit
import SDWebImage


public typealias WebImageUrlStringHandler = (UIImageView, NeedLoadImage) -> String?
public typealias RRCExternalCompletionBlock = SDExternalCompletionBlock

public extension UIImageView {
        
    func loadImage(with urlString: String, placeholder: UIImage? = nil, loadMode: ImageLoader.Mode = .lazy, progress progressBlock: ImageLoader.RRCImageLoaderProgressBlock? = nil, completed completedBlock: RRCExternalCompletionBlock? = nil, handler handleBlock: @escaping WebImageUrlStringHandler = ImageManager.default.imageUrlStringHandler) {
        let needLoadImage = NeedLoadImage(imageUrlString: urlString,
                                          placeholder: placeholder,
                                          loadMode: loadMode,
                                          progress: progressBlock,
                                          completed: completedBlock,
                                          handler: handleBlock)
        
        if let imageUrlString = handleBlock(self, needLoadImage) {
            let url = URL(string: imageUrlString)
            sd_setImage(with: url, placeholderImage: placeholder, options: [.retryFailed, .allowInvalidSSLCertificates ], progress: progressBlock, completed: completedBlock)
        }
        
    }
    
    func loadImage(with url: URL, placeholder: UIImage? = nil, loadMode: ImageLoader.Mode = .lazy, progress progressBlock: ImageLoader.RRCImageLoaderProgressBlock? = nil, completed completedBlock: RRCExternalCompletionBlock? = nil, handler handlerBlock: @escaping WebImageUrlStringHandler = ImageManager.default.imageUrlStringHandler) {
        loadImage(with: url.absoluteString, placeholder: placeholder, loadMode: loadMode, progress: progressBlock, completed: completedBlock, handler: handlerBlock)
    }
}

public extension UIButton {
    func loadImage(with urlString: String, for state: UIControl.State, placeholderImage: UIImage? = nil, completed: RRCExternalCompletionBlock? = nil) {
        if let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: urlString)
            sd_setImage(with: url, for: state, placeholderImage: placeholderImage, options: [.retryFailed, .allowInvalidSSLCertificates ], progress: nil, completed: completed)
        }
    }
}
