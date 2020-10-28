//
//  PostCell.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import Foundation
import UIKit

@objc class PostCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTextLabel: UILabel!
    @IBOutlet weak var thumbView: DynamicImageView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
    }
    
    func setupViews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderColor = UIColor(red: 144/255, green: 147/255, blue: 149/255, alpha: 1).cgColor
        avatarImageView.layer.borderWidth = 1
    }
    
    @objc func setPost(data: PostEntity) {
        categoryLabel.text = data.category
        authorLabel.text = "u/\(data.author)"
        
        titleLabel.text = data.title
        if let body = data.body {
            subTextLabel.text = body
        }
        
        
        if PostCell.isValidImage(data) {
            ImageLoadingWithCache().setImage(url: data.thumbnail!, imageView: thumbView)
        } else {
            thumbView.isHidden = true
        }
        
        votesLabel.text = Util.formatNumbers(value: data.likes)
        commentsLabel.text = Util.formatNumbers(value: data.comments)
    }
    
    @objc static func heightForCell(data: PostEntity, width: Int) -> CGFloat {
        var height: CGFloat = 10 + 60 + 40
        
        
        let titleFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        height = height + data.title.heightWithConstrainedWidth(width: CGFloat(width), font: titleFont)
        
        if let subtext = data.body {
            let subtextFont = UIFont.systemFont(ofSize: 12, weight: .regular)
            height = height + subtext.heightWithConstrainedWidth(width: CGFloat(width), font: subtextFont)
        }
        
        if isValidImage(data) {
            let ratio = Double(data.height!) / Double(data.width!)
            height = height + CGFloat((Double(width) * ratio))
        }
        
        return height;
    }
    
    static func isValidImage(_ data: PostEntity) -> Bool {
        guard let _ = data.width, let _ = data.height, let _ = data.thumbnail else {
            return false
        }
        if data.width == 0 || data.height == 0 {
            return false
        }
        return (data.thumbnail!.contains("jpeg") || data.thumbnail!.contains("jpg") || data.thumbnail!.contains("png"))
    }
}
