//
//  DetailTableViewCell.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

   // MARK: - Properties - UI
   let  descriptionTextView =  UITextView()
   static  let cellId = "detailCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.dataDetectorTypes = .link
        contentView.addSubview(descriptionTextView)
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.textColor = .black
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1.0

        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.addConstraintsToFitToSuperview()

        // Configure the view for the selected state
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
