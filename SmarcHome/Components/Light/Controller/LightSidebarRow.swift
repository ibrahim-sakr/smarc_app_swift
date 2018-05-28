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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateView(room: Room, icon: String) {
        self.label.text = room.name
        self.icon.image = UIImage(named: icon)

        // set bottom border
        let border = CALayer()
        let thick = CGFloat(1.0)
        border.borderColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: mainView.frame.size.height - thick, width:  mainView.frame.size.width, height: mainView.frame.size.height)
        border.borderWidth = thick
        mainView.layer.addSublayer(border)
        mainView.layer.masksToBounds = true
    }
}
