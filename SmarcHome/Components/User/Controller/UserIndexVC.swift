//
//  UserIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class UserIndexVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var selectedUser: User!
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var usersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveUsers()
        self.usersTable.dataSource = self
        self.usersTable.delegate = self
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh Users")
        
        usersTable.refreshControl = refreshControl
    }

    /**
     * get all users from User Service and append them into the table
     */
    func retrieveUsers() -> Void {
        UserService.instance.all(){ (success) in
            if(success) {
                self.usersTable.reloadData()
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

        let actionSheet = UIAlertController(title: UserService.instance.users[indexPath.row].name, message: "What do you need to do", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "edit", style: .default, handler: { (action) in
            self.selectedUser = UserService.instance.users[indexPath.row]
            self.performSegue(withIdentifier: "toEditUser", sender: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "delete", style: UIAlertActionStyle.destructive, handler: { (action) in
            UserService.instance.delete(id: UserService.instance.users[indexPath.row]._id, completion: { (success) in
                if success {
                    print("User Deleted")
                } else {
                    print("Failed to delete user")
                }
            })
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil))

        self.present(actionSheet, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UserEditVC {
            let vc = segue.destination as? UserEditVC
            vc?.user = self.selectedUser
        }
    }
    
    @IBAction func onHomeBtmClicked(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "HomePage")
        self.present(nextVC, animated: true, completion: nil)
    }

    @objc func onRefresh(_ sender: Any) {
        // refresh users list
        print("refreshing users")
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func onNewBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toUserCreate", sender: nil)
    }

}
