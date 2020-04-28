//
//  FirtCollectionViewCell.swift
//  NewProject
//
//  Created by hưng hoàng on 4/20/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FirtCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firtView: UIView!
    @IBOutlet weak var labelContent: UILabel!
    override func awakeFromNib() {
        self.firtView.layer.cornerRadius = 10
        self.firtView.layer.masksToBounds = true
        self.firtView.layer.borderWidth = 1.0
        self.firtView.layer.borderColor = UIColor.black.cgColor
    }
    func setupCell(title:String){
        labelContent.text = title
    }

}
