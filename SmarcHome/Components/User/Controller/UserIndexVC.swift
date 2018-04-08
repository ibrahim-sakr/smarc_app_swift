//
//  UserIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class UserIndexVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var usersTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ْUser VC Loaded")
        self.retrieveUsers()
    }

    func retrieveUsers() -> Void {
        // dispaly loading page
//        let sv = UIViewController.displaySpinner(onView: self.view)
        // load the users
        if UserService.instance.users.count == 0 {
            UserService.instance.all(){ (success) in
                if(success) {
                    self.usersTable.dataSource = self
                    self.usersTable.delegate = self

                    self.viewDidLoad()
                    // hide loading screen
                    //                UIViewController.removeSpinner(spinner: sv)
                } else {
                    print("Failed to retrieve the users")
                }
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserService.instance.users.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = usersTable.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell {
            let userData = UserService.instance.users[indexPath.row]
            cell.updateView(user: userData)

            return cell
        } else {
            return UserListCell()
        }
    }

}
