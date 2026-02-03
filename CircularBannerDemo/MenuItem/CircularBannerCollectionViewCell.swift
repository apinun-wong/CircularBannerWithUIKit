//
//  CircularBannerCollectionViewCell.swift
//  CircularBannerDemo
//
//  Created by Apinun Wongintawang on 3/2/2569 BE.
//

import UIKit

class CircularBannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(item: BannerItem) {
        self.textLabel.text = "\(item.number)"
        self.bgView.backgroundColor = item.color
    }
}
