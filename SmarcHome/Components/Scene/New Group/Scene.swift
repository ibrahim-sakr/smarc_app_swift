//
//  Scene.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/20/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Scene {
    var id: Int64!
    var name: String!
    var points: JSON = JSON()
}
