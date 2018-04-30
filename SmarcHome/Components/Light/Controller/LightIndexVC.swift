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
    @IBOutlet weak var head: UILabel!

    public var roomId: String = "";
    public var headTitle: String = "List Of All Points";
    private var points: [LightPoint] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        // set header title
        self.head.text = self.headTitle;

        // register open sidebar event to the button
        self.lightMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        // enable tap gesture to close side bar on tap
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        self.pointsTable.delegate = self
        self.pointsTable.dataSource = self

        LightService.instance.VC = self
        self.retrievePoints()
    }

    @IBAction func onRefreshBtnClicked(_ sender: Any) {
        let light: RefreshableProtocol = LightService.instance
        light.refresh { (success) in }
    }

    /**
     * get all points from Light Service and append them into the table
     */
    func retrievePoints() -> Void {
        LightService.instance.all(){ (success) in
            if(success) {
                // filter all points by roomId
                // append the results to points array
                self.filterPointsByRoom()
                // reload table data
                self.pointsTable.reloadData()
            } else {
                print("Failed to retrieve the users")
            }
        }
    }
    
    func filterPointsByRoom() {
        if self.roomId != "" {
            self.points = LightService.instance.points.filter({ (point) -> Bool in
                return point.roomId == self.roomId
            })
        } else {
            self.points = LightService.instance.points
        }
    }

    func updateList() {
        // set the new points
        self.filterPointsByRoom()
        self.pointsTable.reloadData()
        // check if it visible to user
//        if let visibleIndexPaths = self.pointsTable.indexPathsForVisibleRows?.index(of: indexPath as IndexPath) {
//            // if visible then
//            if visibleIndexPaths != NSNotFound {
//                // reload just this specific cell
//                self.pointsTable.reloadRows(at: [indexPath], with: .fade)
//            }
//        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.pointsTable.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath) as? LightPointRow {
            cell.updateView(point: self.points[indexPath.row])
            return cell
        }
        return LightPointRow()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}
