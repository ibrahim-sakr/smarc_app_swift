//
//  lightCellTableViewCell.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/13/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class lightCell: UITableViewCell {

    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var pointName: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!

    private var point: LightPoint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(point: LightPoint, defaults: Point?) {
        self.point = point
        self.pointName.text = point.name

        if defaults == nil {
            self.activeSwitch.isOn = false
            self.statusSwitch.isOn = false
        } else {
            self.activeSwitch.isOn = true
            if defaults!.status {
                self.statusSwitch.isOn = true
            } else {
                self.statusSwitch.isOn = false
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onActiveBtnClicked(_ sender: Any) {
        if self.activeSwitch.isOn {
            var point = Point()
            point.type = "light"
            point.status = false
            point.mongoId = self.point._id

            SceneService.instance.addPoint(point: point)
        } else {
            SceneService.instance.removePoint(mongoId: self.point._id)
        }
    }

    @IBAction func onStatusBtnClicked(_ sender: Any) {
        var point = Point()
        point.type = "light"
        point.mongoId = self.point._id

        if self.statusSwitch.isOn {
            point.status = true
        } else {
            point.status = false
        }
        SceneService.instance.updatePoint(point: point)

    }
}
