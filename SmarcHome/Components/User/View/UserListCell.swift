//
//  UserCell.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/8/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!;

    func updateView(user: User) {
        self.name.text = user.name;
    }
}
