//
//  DirectryTableViewCell.swift
//  XTNotebook
//
//  Created by xc on 2022/12/6.
//

import UIKit

class DirectryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //self.editingAccessoryType = .disclosureIndicator
        accessoryType = .disclosureIndicator
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func loadModel(model :DirectryModel) {
        
        titleLabel.text = model.title;
    }
    
}
