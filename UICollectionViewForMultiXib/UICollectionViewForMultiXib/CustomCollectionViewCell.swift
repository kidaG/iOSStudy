//
//  CustomCollectionViewCell.swift
//  UICollectionViewForMultiXib
//
//  Created by yuya on 2016/10/25.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    
    func setLabelString(text:String){
        label.text = text
    }
    
}
