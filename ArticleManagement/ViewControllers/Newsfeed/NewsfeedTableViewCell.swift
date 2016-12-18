//
//  NewsfeedTableViewCell.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {
    @IBOutlet var featureImage: UIImageView!

    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        self.featureImage.layer.borderWidth = 1.5
        
        self.featureImage.layer.borderColor = UIColor.borderColorImage.cgColor
        
//        self.featureImage.translatesAutoresizingMaskIntoConstraints = false
//        let featureImageConstraints: [NSLayoutConstraint] = [
//            featureImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
//            featureImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
//            featureImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
//            featureImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
//        ]
//        
//        NSLayoutConstraint.activate(featureImageConstraints)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
