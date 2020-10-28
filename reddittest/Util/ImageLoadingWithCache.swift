//
//  ImageLoadingWithCache.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

class ImageLoadingWithCache {
    var imageCache = [String: UIImage]()
    
    func setImage(url: String, imageView: UIImageView) {
        if let cachedImage = imageCache[url] {
            imageView.image = cachedImage
            imageView.isHidden = false
        } else {
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        imageView.image = nil
                        imageView.isHidden = true
                    }
                    return
                }
                
                let image = UIImage(data: data!)
                self.imageCache[url] = image
                
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.isHidden = false
                }
            }).resume()
        }
    }
}
