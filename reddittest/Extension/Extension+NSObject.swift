//
//  Extension+NSObject.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import Foundation

extension NSObject {
    public class var className: String {
        return String(describing: self)
    }
    
    static func loadNib<T: NSObject>() -> T? {
        return Bundle.main.loadNibNamed(T.className, owner: nil, options: [:])?.first as? T
    }
}
