//
//  ConditionTableViewCell.swift
//  YardSale
//
//  Created by Caitlyn Chen on 1/3/17.
//  Copyright © 2017 Caitlyn Chen. All rights reserved.
//

import UIKit

class ConditionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var condition: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
