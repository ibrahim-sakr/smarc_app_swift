//
//  UserCell.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/8/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    // private var id: String!;

    @IBOutlet weak var name: UILabel!;

    func updateView(user: User) {
        print(user)
        // self.id = user._id;
        self.name.text = user.name;
    }
}
