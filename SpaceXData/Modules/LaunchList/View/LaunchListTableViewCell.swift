//
//  CustomTableCell.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 18/02/22.
//

import UIKit

class LaunchListTableViewCell: UITableViewCell {
    
   static  let cellId = "Cell"
   var descriptionLabel:  UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.backgroundColor = .clear
        label.textColor = .black
        return label
   }()
    
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.addConstraintsToFitToSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(_ detail: String?) {
        descriptionLabel.text = detail
    }

}
