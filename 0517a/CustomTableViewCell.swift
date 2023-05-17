//
//  CustomTableViewCell.swift
//  0517a
//
//  Created by hokyun Kim on 2023/05/17.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var adFlagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

}
