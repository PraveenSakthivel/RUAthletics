//
//  Description Cell.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/20/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import UIKit

class Description_Cell: UITableViewCell {


    
    @IBOutlet var descbox: UITextView!
    
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descbox.isEditable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
