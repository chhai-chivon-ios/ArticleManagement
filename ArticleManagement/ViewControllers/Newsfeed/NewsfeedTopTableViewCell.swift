//
//  NewsfeedTopTableViewCell.swift
//  ArticleManagement
//
//  Created by sophatvathana on 12/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit

class NewsfeedTopTableViewCell: UITableViewCell {
    @IBOutlet var avatar: UIImageView!

    @IBOutlet var featureImage: UIImageView!
    
    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
