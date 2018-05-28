//
//  RoomIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/8/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class RoomIndexVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UpgradableList {

    @IBOutlet weak var roomsTable: UITableView!
    @IBOutlet weak var roomMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        RoomService.instance.VC = self

        roomsTable.delegate = self
        roomsTable.dataSource = self

        RoomService.instance.all { (success) in }

        // register open sidebar event to the button
        roomMenuBtn.target = self.revealViewController()
        roomMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    }

    @IBAction func onHomeBtnClicked() {
        let storyBoard: UIStoryboard = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
        self.present(newViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomService.instance.rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomRow", for: indexPath) as! RoomRow
        cell.setup(room: RoomService.instance.rooms[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("=====================")
        print("Room Row Clicked")
        print(indexPath)
        print("=====================")
    }

    func updateList() {
        self.roomsTable.reloadData()
    }
    
}
