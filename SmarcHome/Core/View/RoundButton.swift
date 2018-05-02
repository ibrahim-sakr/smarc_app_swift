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

//    @IBInspectable var backgroundImageColor: UIColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1) {
//        didSet {
//            refreshColors(color: backgroundImageColor)
//        }
//    }

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
//        refreshColors(color: backgroundImageColor)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
//    func refreshColors(color: UIColor) {
//        let image = createImage(color: color)
//        setBackgroundImage(image, for: UIControlState.normal)
//        clipsToBounds = true
//    }
//
//    func createImage(color: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
//        color.setFill()
//        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
//        let image = UIGraphicsGetImageFromCurrentImageContext()!
//        return image
//    }
}
