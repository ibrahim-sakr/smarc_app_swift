//
//  LightSidebarVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightSidebarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var roomsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Light Sidebar VC Loaded")
        getRooms()
        self.roomsTable.delegate = self
        self.roomsTable.dataSource = self
    }

    @IBAction func onHomeBtmClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomePage")
        self.present(newViewController, animated: true, completion: nil)
    }

    @IBAction func onAllPointsBtnClicked(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LightPoints") as? LightIndexVC
        controller?.roomId = ""
        controller?.headTitle = "List Of All Points"
        
        let nextController = revealViewController().frontViewController as! UINavigationController
        nextController.pushViewController(controller!, animated: false)
        revealViewController().pushFrontViewController(nextController, animated: true)
    }

    func getRooms() {
        RoomService.instance.all { (success) in
            if success {
                self.roomsTable.reloadData()
            } else {
                print("can't fetch rooms")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomService.instance.rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.roomsTable.dequeueReusableCell(withIdentifier: "LightSidebarRow", for: indexPath) as? LightSidebarRow {
            cell.updateView(room: RoomService.instance.rooms[indexPath.row])

            return cell
        }

        return LightSidebarRow()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LightPoints") as? LightIndexVC
        controller?.roomId = RoomService.instance.rooms[indexPath.row]._id
        controller?.headTitle = RoomService.instance.rooms[indexPath.row].name
        
        let nextController = revealViewController().frontViewController as! UINavigationController
        nextController.pushViewController(controller!, animated: false)
        revealViewController().pushFrontViewController(nextController, animated: true)
    }
}
