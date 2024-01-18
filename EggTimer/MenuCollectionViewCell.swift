//
//  MenuCollectionViewCell.swift
//  EggTimer
//
//  Created by Newarpunk on 3/10/20.
//  Copyright © 2020 Akash Stha. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var menuItemView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuItemView.layer.cornerRadius = 25
        menuItemView.layer.borderColor = UIColor.brown.cgColor
        menuItemView.layer.borderWidth = 3
        labelView.layer.cornerRadius = 17
    }
    
}
