//
//  TestImageView.swift
//  ESWebImageDemo
//
//  Created by 罗树新 on 2020/12/21.
//

import UIKit

class TestImageView: UIImageView {
    
    override func layoutSubviews() {
        print("image view begain layout")
        superview?.layoutSubviews()
        print("image view end layout")
    }
}
