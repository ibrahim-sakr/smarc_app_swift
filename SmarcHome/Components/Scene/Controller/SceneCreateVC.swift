//
//  SceneCreateVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SceneCreateVC: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var sceneName: UITextField!

    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    var timer: Timer = Timer()

    override func viewDidLoad() {
        // cretae empty scene
        SceneService.instance.scene = Scene()

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
        
        sceneName.addTarget(self, action: #selector(self.sceneNameDidChange(_:)), for: UIControlEvents.editingChanged)

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

    @IBAction func onBackBtnClicked(_ sender: Any) {
        let newViewController = UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "SceneIndex")
        self.present(newViewController, animated: true, completion: nil)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "lightsTable"),
            UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "shuttersTable")
        ]
    }

    @IBAction func save() {
        SceneService.instance.create()

        let newViewController = UIStoryboard(name: "Scene", bundle: nil).instantiateViewController(withIdentifier: "SceneIndex")
        self.present(newViewController, animated: true, completion: nil)
    }

}
