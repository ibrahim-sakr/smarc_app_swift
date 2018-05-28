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
    
    private var user: User!
    private var index: Int!
    private var origin: UserIndexVC!

    func setup(index: Int, user: User, origin: UserIndexVC) {
        self.user = user
        self.index = index
        self.origin = origin
        self.updateView()
    }

    func updateView() {
        self.name.text = self.user.name;
        self.selectedBackgroundView?.backgroundColor = UIColor.red
    }

    @IBAction func onOptBtnClicked() {
        let actionSheet = UIAlertController(title: self.user.name, message: UserConst.ACTION_SHEET_MESSAGE, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: UserConst.ACTION_SHEET_EDIT, style: .default, handler: { (action) in
            self.origin.selectedUser = self.user
            self.origin.performSegue(withIdentifier: UserConst.SEGUE_TO_EDIT_USER, sender: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: UserConst.ACTION_SHEET_DELETE, style: UIAlertActionStyle.destructive, handler: { (action) in
            UserService.instance.delete(id: self.user._id, completion: { (success) in
                if success {
                    print("User Deleted")
                } else {
                    print("Failed to delete user")
                }
            })
        }))

        actionSheet.addAction(UIAlertAction(title: UserConst.ACTION_SHEET_CANCEL, style: UIAlertActionStyle.cancel, handler: nil))

        self.origin.present(actionSheet, animated: true, completion: nil)
    }
}
