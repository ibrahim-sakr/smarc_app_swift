//
//  RoundButton.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/30/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

@IBDesignable class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        // Common logic goes here
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

}
