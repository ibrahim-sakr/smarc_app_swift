//
//  LightSidebarVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightSidebarVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UpgradableList {

    @IBOutlet weak var roomsTable: UITableView!
    @IBOutlet weak var sidebarProfileView: SidebarProfileView!
    
    private let staticLinks: [[String: String]] = [
        [
            "name": "home",
            "icon": "home-22"
        ],
        [
            "name": "all points",
            "icon": "lights-22"
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        getRooms()
        self.roomsTable.delegate = self
        self.roomsTable.dataSource = self

        self.sidebarProfileView.origin = self
        
        revealViewController().rearViewRevealWidth = self.view.frame.width - 50
    }

    func getRooms() {
        RoomService.instance.VC = self
        RoomService.instance.all { (success) in }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }

        return RoomService.instance.rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.roomsTable.dequeueReusableCell(withIdentifier: "LightSidebarRow", for: indexPath) as? LightSidebarRow {

            var x: Room!
            var icon: String!

            if indexPath.section == 0 {
                x = Room()
                x.name = self.staticLinks[indexPath.row]["name"]
                icon = self.staticLinks[indexPath.row]["icon"]
            } else {
                x = RoomService.instance.rooms[indexPath.row]
                icon = "room-22"
            }

            cell.updateView(room: x, icon: icon)

            return cell
        }
        return LightSidebarRow()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            self.runStaticLink(indexPath: indexPath)
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LightPoints") as? LightIndexVC
            controller?.roomId = RoomService.instance.rooms[indexPath.row]._id
            controller?.headTitle = RoomService.instance.rooms[indexPath.row].name

            revealViewController().pushFrontViewController(controller, animated: true)
        }
    }

    func runStaticLink(indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LightPoints") as? LightIndexVC
            controller?.roomId = ""
            controller?.headTitle = "List Of All Points"
            revealViewController().pushFrontViewController(controller, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "quick links"
        } else {
            return "rooms"
        }
    }
    
    func updateList() {
        self.roomsTable.reloadData()
    }

}
