//
//  CustomCell.swift
//  LocalFoodSample02
//
//  Created by Ryuton on 2018/05/04.
//  Copyright © 2018年 LikeLake. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imgSample:UIImageView!
    @IBOutlet var lblSample:UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}
