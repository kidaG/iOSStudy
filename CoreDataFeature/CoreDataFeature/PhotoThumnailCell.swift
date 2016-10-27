//
//  PhotoThumnailCell.swift
//  CoreDataFeature
//
//  Created by yuya on 2015/11/25.
//  Copyright © 2015年 yuya. All rights reserved.
//

import UIKit

class PhotoThumnailCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func setThumnail(thumnailImage:UIImage){
        self.imgView?.image = thumnailImage
    }
}
