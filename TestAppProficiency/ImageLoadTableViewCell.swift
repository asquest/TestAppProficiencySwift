//
//  ImageLoadTableViewCell.swift
//  TestAppProficiency
//
//  Created by user167484 on 3/17/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class ImageLoadTableViewCell: UITableViewCell {
    var titleLabel = UILabel()
    var descLabel = UILabel()
    var imageContent = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageContent)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        descLabel.numberOfLines = 0

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup() {
        imageContent.frame.size = CGSize(width: 50, height: 50)
        titleLabel.frame.size.height = 20
        descLabel.frame.size.height = 20
        let a = NSLayoutConstraint(item: imageContent, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: 20)
        let b = NSLayoutConstraint(item: imageContent, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 20)
        let c = NSLayoutConstraint(item: imageContent, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1, constant: 20)
        
        let d = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: imageContent, attribute: .trailing, multiplier: 1, constant: 20)
       let f = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 20)
        let g = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: 20)

        let e = NSLayoutConstraint(item: descLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        let h = NSLayoutConstraint(item: descLabel, attribute: .leading, relatedBy: .equal, toItem: imageContent, attribute: .trailing, multiplier: 1, constant: 20)
        let i = NSLayoutConstraint(item: descLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: 20)
        let j = NSLayoutConstraint(item: descLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([a,b,c,d,e,f,g,h,i,j])
//        NSLayoutConstraint.activate([a,b,c,d])

    }

}
