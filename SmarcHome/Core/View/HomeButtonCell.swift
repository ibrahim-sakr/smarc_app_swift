//
//  homeButton.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeButtonCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!

    func updateView(name: String, background: UIColor) {
        self.name.text = name
        self.contentView.backgroundColor = background
    }

}
