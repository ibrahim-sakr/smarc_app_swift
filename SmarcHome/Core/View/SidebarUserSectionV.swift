//
//  SidebarUserSectionV.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class SidebarUserSectionV: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SidebarUserSection", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func onLabelClickd(_ sender: Any) {
        print("Common Button Pressed")
    }
    
}
