//
//  LightPointRow.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/12/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightPointRow: UITableViewCell {
    
    private var point: LightPoint!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var pointName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // super.setSelected(selected, animated: animated)
    }

    func updateView(point: LightPoint) {
        self.point = point
        self.pointName.text = point.name
        if point.status {
            self.switchBtn.setOn(true, animated: false)
        } else {
            self.switchBtn.setOn(false, animated: false)
        }
    }

    @IBAction func switchToggled(_ sender: Any) {
        LightService.instance.toggle(point: self.point) { (success) in
            if !success {
                self.switchBtn.setOn(!self.switchBtn.isOn, animated: true)
            }
        }
    }
}
