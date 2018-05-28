//
//  SceneEditVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SceneEditVC: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var sceneName: UITextField!
    @IBOutlet weak var vcNavigationBar: UINavigationBar!
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    var timer: Timer = Timer()
    var customTitle: String!

    override func viewDidLoad() {
        self.vcNavigationBar.topItem?.title = customTitle
        sceneName.text = SceneService.instance.scene.name
        sceneName.addTarget(self, action: #selector(self.sceneNameDidChange(_:)), for: UIControlEvents.editingChanged)

        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }

        super.viewDidLoad()
    }

    @objc func sceneNameDidChange(_ textField: UITextField) {
        timer.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 0.6,
            target: self,
            selector: #selector(self.changeTimeout),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func changeTimeout() {
        SceneService.instance.scene.name = self.sceneName.text
    }

    @IBAction func onCancelBtnClicked(_ sender: Any) {
        let newViewController = UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "SceneIndex")
        self.present(newViewController, animated: true, completion: nil)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        return [
            UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "lightsTable"),
            UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "shuttersTable")
        ]
    }

    @IBAction func update() {
        SceneService.instance.update()

        let newViewController = UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "SceneIndex")
        self.present(newViewController, animated: true, completion: nil)
    }

}
