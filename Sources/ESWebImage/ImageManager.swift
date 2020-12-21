//
//  ImageManager.swift
//  
//
//  Created by 罗树新 on 2020/12/17.
//

import Foundation
import UIKit

public struct ImageManager {    
    public static let `default` = ImageManager { (imageView, needLoadImage) -> String? in
        let scale = UIScreen.main.scale
        let imageUrlString = needLoadImage.imageUrlString
        switch needLoadImage.loadMode {
        case .lazy:
            if imageView.bounds.width <= 0.01 || imageView.bounds.height <= 0.01 {
                imageView.needLoadImage = needLoadImage
                return nil
            } else {
                let width = roundf(Float(imageView.bounds.width) * Float(scale))
                let height = roundf(Float(imageView.bounds.height) * Float(scale))
                let imageUrlStr = "imageView2/1/w/\(width)/h/\(height)"
                return imageUrlString.urlString(for: imageUrlStr)
            }
            
        case .force:
            if imageView.bounds.width <= 0.01 || imageView.bounds.height <= 0.01 {
                var superView = imageView.superview
                while let tView = superView {
                    tView.setNeedsLayout()
                    tView.layoutIfNeeded()
                    superView = tView.superview
                }
            }
            let width = roundf(Float(imageView.bounds.width) * Float(scale))
            let height = roundf(Float(imageView.bounds.height) * Float(scale))
            let imageUrlStr = "imageView2/1/w/\(width)/h/\(height)"
            return imageUrlString.urlString(for: imageUrlStr)
        case .forceLazy:
            imageView.needLoadImage = needLoadImage
            return nil
        case .origin:
            if imageView.bounds.width <= 0.01 || imageView.bounds.height <= 0.01 {
                return imageUrlString
            } else {
                let width = roundf(Float(imageView.bounds.width) * Float(scale))
                let height = roundf(Float(imageView.bounds.height) * Float(scale))
                let imageUrlStr = "imageView2/1/w/\(width)/h/\(height)"
                return imageUrlString.urlString(for: imageUrlStr)
            }
        }
    }
    
    public var imageUrlStringHandler: WebImageUrlStringHandler
    
    public static func startLazy() {
        UIImageView.initializeMethod()
    }
        
    init(_ imageUrlStringHandler: @escaping WebImageUrlStringHandler) {
        self.imageUrlStringHandler = imageUrlStringHandler
    }
}

fileprivate extension String {
    func urlString(for string: String) -> String? {
        guard self.count > 0 else { return nil }
        
        let urlComponents = self.components(separatedBy: "?")
        
        if urlComponents.count == 2, let firstComponents = urlComponents.first ,let lastComponents = urlComponents.last {
            var quertComponents = lastComponents.components(separatedBy: "|")
            
            quertComponents.append(string)
            let str = [firstComponents, quertComponents.joined(separator: "|")].joined(separator: "?")
            return str
        } else {
            let str = [self, string].joined(separator: "?")
            return str
        }
    }
}


