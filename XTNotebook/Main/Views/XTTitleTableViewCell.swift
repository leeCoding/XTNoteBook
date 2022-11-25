//
//  XTTitleTableViewCell.swift
//  XTNotebook
//
//  Created by xc on 2022/11/25.
//

import UIKit

class XTTitleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }

    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadModel(model:NoteModel){
        
        bigTitleLabel.text = model.title
        contentLabel.text = model.content
        dateLabel.text = model.date
        
    }
}
