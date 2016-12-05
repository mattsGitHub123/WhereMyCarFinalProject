//
//  LoggedLocationTableViewCell.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/5/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import UIKit

class LoggedLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
