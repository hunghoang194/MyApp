//
//  SecondTableViewCell.swift
//  NewProject
//
//  Created by hưng hoàng on 4/21/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var labelSecondContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.secondView.layer.cornerRadius = 10
        self.secondView.layer.masksToBounds = true
        self.secondView.layer.borderWidth = 1.0
        self.secondView.layer.borderColor = UIColor.black.cgColor
    }
    
}
