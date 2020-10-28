//
//  DynamicImageView.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import Foundation

class DynamicImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var intrinsicContentSize: CGSize {
        if let image = self.image {
            let width = image.size.width
            let height = image.size.height
            let viewWidth = self.frame.size.width
            
            let ratio = height / width
            let scaledHeight = viewWidth * ratio
            
            return CGSize(width: viewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
}
