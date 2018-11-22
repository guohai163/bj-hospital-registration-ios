//
//  DepartmentTableViewCell.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/21.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var depIDLabel: UILabel!
    
    @IBOutlet weak var depNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
