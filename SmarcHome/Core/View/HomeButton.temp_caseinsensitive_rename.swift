//
//  homeButton.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeButton: UI {
    
    @IBOutlet weak var name: UILabel!;
    
    func updateView(user: User) {
        self.name.text = user.name;
    }
}
