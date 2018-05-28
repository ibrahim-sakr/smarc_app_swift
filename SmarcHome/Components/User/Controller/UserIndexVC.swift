//
//  UserIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class UserIndexVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let refreshControl = UIRefreshControl()
    var selectedUser: User!

    @IBOutlet weak var usersTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveUsers()
        self.usersTable.dataSource = self
        self.usersTable.delegate = self

        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
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
        cell.setup(index: indexPath.row, user: UserService.instance.users[indexPath.row], origin: self)
        
        return cell
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
        UserService.instance.refresh { (success) in
            if success {
                self.refreshControl.endRefreshing()
            } else {
                print("Failed to load users")
            }
        }
    }
    
    @IBAction func onNewBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toUserCreate", sender: nil)
    }

}
