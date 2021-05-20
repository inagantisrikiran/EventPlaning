//
//  TableViewCell.swift
//  EventPlaning
//
//  Created by SRIKIRAN INAGANTI on 5/19/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        makeRoundedAndShadowed(view:shadowView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeRoundedAndShadowed(view: UIView) {
        shadowView.layer.cornerRadius = 5
        shadowView.layer.masksToBounds = true
        shadowView.layer.shadowColor = UIColor.white.cgColor
       // shadowView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowView.layer.shadowOpacity = 0.9
        shadowView.layer.shadowRadius = 5
    }
}
