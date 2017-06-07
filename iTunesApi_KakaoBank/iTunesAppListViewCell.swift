//
//  iTunesAppListViewCell.swift
//  iTunesApi_KakaoBank
//
//  Created by Teddy Kwak on 2017. 6. 5..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit

class iTunesAppListViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var appImgView: UIImageView! {
        didSet{
            appImgView.layer.borderColor = UIColor.lightGray.cgColor
            appImgView.layer.borderWidth = 0.5
            appImgView.layer.cornerRadius = 15
            appImgView.layer.masksToBounds = true
        }
    }
    
    var model : iTunesAppModel! {
        didSet {
            self.titleLabel.text = model.name
            self.priceLabel.text = model.price
            self.categoryLabel.text = model.category
            self.appImgView.kf.setImage(with: URL(string: model.imgUrl))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
