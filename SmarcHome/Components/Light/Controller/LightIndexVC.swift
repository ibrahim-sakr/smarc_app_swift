//
//  LightIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightIndexVC: UIViewController, UpgradableList, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lightMenuBtn: UIButton!
    @IBOutlet weak var pointsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Light VC Loaded")

        self.lightMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        self.pointsTable.delegate = self
        self.pointsTable.dataSource = self

        LightService.instance.VC = self
        self.retrieveUsers()
    }

    /**
     * get all users from User Service and append them into the table
     */
    func retrieveUsers() -> Void {
        LightService.instance.all(){ (success) in
            if(success) {
                self.pointsTable.reloadData()
            } else {
                print("Failed to retrieve the users")
            }
        }
    }

    func updateList(index: Int) {
        // create IndexPath with cell index and section index
        let indexPath = IndexPath(item: index, section: 0)
        // check if it visible to user
        if let visibleIndexPaths = self.pointsTable.indexPathsForVisibleRows?.index(of: indexPath as IndexPath) {
            // if visible then
            if visibleIndexPaths != NSNotFound {
                // reload just this specific cell
                self.pointsTable.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LightService.instance.points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.pointsTable.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath) as? LightPointRow {
            cell.updateView(point: LightService.instance.points[indexPath.row])
            return cell
        }
        return LightPointRow()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

}
