//
//  RoomSidebarVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/24/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class RoomSidebarVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UpgradableList {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var sidebarProfileView: SidebarProfileView!
    
    private let staticLinks: [[String: String]] = [
        [
            "name": "home",
            "icon": "home-22"
        ],
        [
            "name": "all rooms",
            "icon": "room-22"
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRooms()
        self.table.delegate = self
        self.table.dataSource = self
        
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RoomSidebarRow", for: indexPath) as? RoomSidebarRow {
            print("RoomSidebarRow")

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

        return RoomSidebarRow()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            self.runStaticLink(indexPath: indexPath)
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RoomPage") as? RoomVC
            revealViewController().pushFrontViewController(controller, animated: true)
        }
    }
    
    func runStaticLink(indexPath: IndexPath) {
        if indexPath.row == 0 {
            let newViewController = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil).instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let nextVC = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil).instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
            self.present(nextVC, animated: true, completion: nil)
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
        self.table.reloadData()
    }

}
