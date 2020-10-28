//
//  Extension+UITableView.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cell: [String]) {
        cell.forEach {
            self.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(index: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: index) as? T else { fatalError("Error: casting \(T.className)") }
        return cell
    }
}
