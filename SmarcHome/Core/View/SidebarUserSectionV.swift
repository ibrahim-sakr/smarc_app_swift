//
//  SidebarUserSectionV.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit
import SwiftyJSON

class SidebarView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var table: UITableView!

    var origin: UIViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("SidebarView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.image.layer.cornerRadius = self.image.frame.size.width / 2
        self.image.clipsToBounds = true
        
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(red:229/255, green:229/255, blue:229/255, alpha: 1).cgColor

        self.name.text = AuthService.instance.user["name"].stringValue
    }

    @IBAction func onLogoutClickd(_ sender: Any) {
        AuthService.instance.logout();

        let storyBoard: UIStoryboard = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: CoreConst.MAIN_PAGE_ID)
        self.origin.present(nextVC, animated: true, completion: nil)
    }

}
