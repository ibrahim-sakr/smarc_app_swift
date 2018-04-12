//
//  LightPointRow.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/12/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightPointRow: UITableViewCell {
    
    @IBOutlet weak var pointName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateView(point: LightPoint) {
        self.pointName.text = point.name
        
        if point.status {
            self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        } else {
            self.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
        }
    }

}
