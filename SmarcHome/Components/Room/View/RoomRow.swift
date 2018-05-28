//
//  RoomRaw.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/24/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class RoomRow: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!

    public private(set) var id: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(room: Room) {
        self.name.text = room.name
        self.id = room._id
    }
}

