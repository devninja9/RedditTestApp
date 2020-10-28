//
//  Util.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import Foundation

class Util {
    static func formatNumbers(value: Int?) -> String {
        if value == nil {
            return "0"
        }
        
        if value! > 990000 {
            return String(format: "%.1fM", (Double(value!) / 10000))
        } else if value! > 999 {
            return String(format: "%.1fK", (Double(value!) / 1000))
        } else {
            return "\(value!)"
        }
    }
}
