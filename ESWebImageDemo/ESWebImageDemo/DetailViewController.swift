//
//  DetailViewController.swift
//  ESWebImage
//
//  Created by 罗树新 on 2020/12/20.
//

import UIKit
import ESWebImage
class DetailViewController: UIViewController {

    
    var didupdateViewConstraints = false
    var imageUrlString: String? {
        didSet {
            if let imgUrl = imageUrlString {
                self.imageView.loadImage(with: imgUrl)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    override func updateViewConstraints() {
        print("DetailViewController updateViewConstraints")
        if didupdateViewConstraints == false {
            imageView.snp.makeConstraints { (make) in
                make.leading.trailing.equalTo(view)
                make.centerY.equalTo(view)
                make.height.equalTo(400)
            }
        }
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("DetailViewController viewDidLayoutSubviews")
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

}
