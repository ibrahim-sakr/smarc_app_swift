//
//  LightConst.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

class LightConst {
    static var INDEX_URL: String {
        return "\(CoreConst.BASE_API_URL)/light"
    }

    static var TOGGLE_URL: String {
        return "\(CoreConst.BASE_API_URL)/light/toggle/"
    }
}
