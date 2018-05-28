//
//  Point.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/22/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

struct Point: Codable {
    var mongoId: String!
    var type: String!
    var status: Bool!
    
    var dictionary: [String: Any] {
        return [
            "mongoId": mongoId,
            "type": type,
            "status": status
        ]
    }
}
