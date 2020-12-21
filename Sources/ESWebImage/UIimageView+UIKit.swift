//
//  File.swift
//  
//
//  Created by 罗树新 on 2020/12/21.
//

import UIKit

private let onceToken = "Method Swizzling"

extension UIImageView {
    private struct AssociatedKey {
        static var needLoadImage: String = "needLoadImageUrlString"
    }
        
    var needLoadImage: NeedLoadImage? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.needLoadImage) as? NeedLoadImage
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.needLoadImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public class func initializeMethod() {
        
        if self != UIImageView.self {
            return
        }
        //DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
        DispatchQueue.once(token: onceToken) {
            let originalSelector = #selector(layoutSubviews)
            let swizzledSelector = #selector(swizzled_layoutSubviews)
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
            let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
    
    
    @objc func swizzled_layoutSubviews() {
        //需要注入的代码写在此处
        self.swizzled_layoutSubviews()
        if let needLoadImage = needLoadImage {
            loadImage(with: needLoadImage.imageUrlString, placeholder: needLoadImage.placeholder, loadMode: needLoadImage.loadMode, progress: needLoadImage.progress, completed: { [weak self] (image, error, cacheType, url) in
                self?.needLoadImage?.completed?(image, error, cacheType, url)
                self?.needLoadImage = nil
            }, handler: needLoadImage.handler)
        }
    }
}
