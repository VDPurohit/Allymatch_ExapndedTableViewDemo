//
//  ProductTableViewCell.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var labelProductName: UILabel!
    @IBOutlet var checkMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
