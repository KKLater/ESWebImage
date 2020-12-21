//
//  ImageCell.swift
//  ESWebImage
//
//  Created by 罗树新 on 2020/12/20.
//

import UIKit
import SnapKit
class ImageCell: UITableViewCell {
    
    var didUpdateConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(imgView)
    }
        
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    override func updateConstraints() {
        if didUpdateConstraints == false {
            imgView.snp.makeConstraints { (make) in
                make.leading.equalTo(contentView).offset(10)
                make.top.equalTo(contentView).offset(10)
                make.bottom.equalTo(contentView).offset(-10)
                make.width.equalTo(100)
            }
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
        
    }
    
    override func layoutSubviews() {
        print("cell begain layout")
        super.layoutSubviews()
        print("cell end layout")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: TestImageView =  {
        let imageView = TestImageView()
        return imageView
    }()
}
