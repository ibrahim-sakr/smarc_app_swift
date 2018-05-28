//
//  LightsTableVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/13/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LightsTableVC: UIViewController, UpgradableList, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lightsTable: UITableView!
    
    // var scene: Scene!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lightsTable.delegate = self
        self.lightsTable.dataSource = self

        LightService.instance.VC = self
        LightService.instance.all { (success) in }
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "lights")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LightService.instance.points.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as! lightCell
        let point = LightService.instance.points[indexPath.row]
        let scenePoint = SceneService.instance.getPoint(mongoId: point._id)
        // get all scene points from SceneService.instance.scene.points
         cell.setup(point: point, defaults: scenePoint)

        return cell
    }

    func updateList() {
        self.lightsTable.reloadData()
    }

}
