//
//  LightSidebarRow.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/12/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightSidebarRow: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateView(room: Room) {
        self.label.text = room.name
    }
}
