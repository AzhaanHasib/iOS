//
//  DetailTableViewCell.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 19/02/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

   // MARK: - Properties - UI
    static  let cellId = "detailCell"
    var descriptionTextView : UITextView = {
          let textView = UITextView()
          textView.isScrollEnabled = false
          textView.isEditable = false
          textView.dataDetectorTypes = .link
          textView.font = .systemFont(ofSize: 16)
          textView.backgroundColor = .clear
          textView.textColor = .black
          textView.layer.borderColor = UIColor.lightGray.cgColor
           textView.layer.borderWidth = 1.0
          return textView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.addConstraintsToFitToSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(detail: String?) {
        descriptionTextView.text = detail
    }

}
