//
//  ImageCell.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/18/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var thumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
