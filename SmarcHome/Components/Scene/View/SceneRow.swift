//
//  SceneRow.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class SceneRow: UITableViewCell {

    @IBOutlet weak var sceneName: UILabel!
    
    var id: Int64!

    override func awakeFromNib() {
        // super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // super.setSelected(selected, animated: animated)
    }

    func setup(id: Int64, name: String) {
        self.sceneName.text = name
        self.id = id
    }

    @IBAction func ssx() {
        print("FUCKIN CLICKED")
    }

}
