//
//  LightSidebarRow.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/12/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightSidebarRow: UITableViewCell {

    @IBOutlet weak var staticBtm: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onStaticBtmClicked(_ sender: Any) {
        print("static button clicked")
    }

    func updateView(room: Room) {
        self.staticBtm.setTitle(room.name, for: .normal)
    }
}
