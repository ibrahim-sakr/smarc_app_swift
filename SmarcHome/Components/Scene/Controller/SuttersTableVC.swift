//
//  SuttersTableVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/13/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SuttersTableVC: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "shutters")
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
