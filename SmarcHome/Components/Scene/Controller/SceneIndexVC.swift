//
//  SceneIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/8/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class SceneIndexVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UpgradableList {

    @IBOutlet weak var scenesTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scenesTable.delegate = self
        scenesTable.dataSource = self

        SceneService.instance.VC = self
        SceneService.instance.all()
    }

    @IBAction func onHomeBtnClicked(_ sender: Any) {
        let newViewController = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil).instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
        self.present(newViewController, animated: true, completion: nil)
    }

    @IBAction func onAddBtnClicked(_ sender: Any) {
        let newViewController = UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "SceneCreate")
        self.present(newViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SceneService.instance.scenes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SceneCell", for: indexPath) as! SceneRow
        cell.setup(id: SceneService.instance.scenes[indexPath.row].id, name: SceneService.instance.scenes[indexPath.row].name!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath) as! SceneRow
        let id: Int64 = cell.id

        let runAction = UIContextualAction(
            style: .normal,
            title: "RUN",
            handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                if SceneService.instance.scene == nil {
                    let cell = tableView.cellForRow(at: indexPath) as! SceneRow
                    let id: Int64 = cell.id
                    SceneService.instance.find(id: id)
                }

                SceneService.instance.run(id: Int64(exactly: id)!, completion: { (success) in
                    if success {
                        print("===============")
                        print("Run Succeeded")
                        print("===============")
                    } else {
                        print("===============")
                        print("Failed to Run")
                        print("===============")
                    }
                })

                return success(true)
            }
        )
        runAction.backgroundColor = CoreConst.red

        return UISwipeActionsConfiguration(actions: [runAction])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath) as! SceneRow
        let id: Int64 = cell.id

        let editAction = UIContextualAction(
            style: .normal,
            title:  "EDIT",
            handler: { (ac: UIContextualAction, view:UIView, success:(Bool) -> Void) in
                SceneService.instance.find(id: Int64(exactly: id)!)

                let newViewController = UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "SceneEdit") as! SceneEditVC

                newViewController.customTitle = (tableView.cellForRow(at: indexPath) as! SceneRow).sceneName.text
                self.present(newViewController, animated: true, completion: nil)

                return success(true)
            }
        )
        editAction.backgroundColor = CoreConst.gray

        let deleteAction = UIContextualAction(
            style: .normal,
            title:  "DELETE",
            handler: { (ac: UIContextualAction, view:UIView, success:(Bool) -> Void) in
                SceneService.instance.delete(id: Int64(exactly: id)!)

                return success(true)
            }
        )
        deleteAction.backgroundColor = CoreConst.orange

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    func updateList() {
        self.scenesTable.reloadData()
    }

}
