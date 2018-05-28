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
    @IBOutlet weak var switchBtn: SmarcSwitch!
    @IBOutlet weak var pointName: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // super.setSelected(selected, animated: animated)
    }

    func updateView(index: Int, point: LightPoint) {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        self.point = point
        self.pointName.text = point.name
        if point.status {
            self.switchBtn.isOn = true
            self.onBackground(index: index)
        } else {
            self.switchBtn.isOn = false
            self.offBackground(index: index)
        }
    }

    func offBackground(index: Int){
            self.cellView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
            self.imageBackground.backgroundColor = UIColor(white: 0.93, alpha: 1.0)
    }

    func onBackground(index: Int){
            self.cellView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            self.imageBackground.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
    }

    @IBAction func switchToggled(_ sender: Any) {
        self.switchToggle()
    }

    func switchToggle() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        LightService.instance.toggle(point: self.point) { (success) in
            if !success {
                self.switchBtn.isOn = !self.switchBtn.isOn
            }
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }
}
