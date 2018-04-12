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

    @IBAction func onHomeBtmClicked(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)

        let nextVC = storyBoard.instantiateViewController(withIdentifier: "HomePage")

        self.present(nextVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveUsers()
        self.usersTable.dataSource = self
        self.usersTable.delegate = self
    }

    /**
     * get all users from User Service and append them into the table
     */
    func retrieveUsers() -> Void {
        UserService.instance.all(){ (success) in
            if(success) {

            } else {
                print("Failed to retrieve the users")
            }
        }
    }
    
    /**
     * define and return the total number of sections into the table
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    /**
     * return the total number of row the currently into the table
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserService.instance.users.count
    }

    /**
     * render the cell or the row
     * it get the template that we defined for the cell, then pass some data to it
     * finally append it to the table with dequeueReusableCell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTable.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        cell.updateView(user: UserService.instance.users[indexPath.row])
        
        return cell
    }
    
    /**
     * this method just for UI
     * it deselect the row so it back to the default state
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.usersTable.deselectRow(at: indexPath, animated: true)
    }
    
    /**
     * if we gonna navigate to a certain ViewController
     * then we pass to it some data before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "EditUser",
            let destination = segue.destination as? UserEditVC,
            let blogIndex = self.usersTable.indexPathForSelectedRow?.row {

            destination.user = UserService.instance.users[blogIndex]
        }
    }

}
