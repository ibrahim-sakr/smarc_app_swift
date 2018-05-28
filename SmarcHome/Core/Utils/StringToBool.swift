//
//  StringToBool.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/22/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
