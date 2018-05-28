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
    @IBOutlet weak var headBG: UIView!
    
    public var roomId: String = "";
    public var headTitle: String = "List Of All Points";
    private var points: [LightPoint] = [];
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // set header title
        self.head.text = self.headTitle;
        self.headBG.backgroundColor = CoreConst.orange

        // register open sidebar event to the button
        self.lightMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        // enable tap gesture to close side bar on tap
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        self.pointsTable.delegate = self
        self.pointsTable.dataSource = self

        LightService.instance.VC = self
        self.retrievePoints()

        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
        pointsTable.refreshControl = refreshControl
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
            cell.updateView(index: indexPath.row, point: self.points[indexPath.row])
            return cell
        }
        return LightPointRow()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    @objc func onRefresh(_ sender: Any) {
        LightService.instance.refresh { (success) in
            if success {
                self.refreshControl.endRefreshing()
            } else {
                print("Failed to load Lights")
            }
        }
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(
            style: .normal,
            title: "ON",
            handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                if !LightService.instance.points[indexPath.row].status {
                    // send toggle request
                    let cell = tableView.cellForRow(at: indexPath) as! LightPointRow
                    cell.switchToggle()
                }

                return success(true)
            }
        )
        closeAction.backgroundColor = CoreConst.red

        return UISwipeActionsConfiguration(actions: [closeAction])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(
            style: .normal,
            title:  "OFF",
            handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                if LightService.instance.points[indexPath.row].status {
                    // send toggle request
                    let cell = tableView.cellForRow(at: indexPath) as! LightPointRow
                    cell.switchToggle()
                }
                
                return success(true)
            }
        )
        closeAction.backgroundColor = CoreConst.gray
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }

}
