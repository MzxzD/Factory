//
//  PreviewDataTableViewCell.swift
//  Factoy
//
//  Created by Mateo Došlić on 07/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit

class PreviewDataTableViewCell: UITableViewCell {

    
    // MARK: Properties
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
