//
//  Point.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

struct LightPoint: Decodable {
    public var _id: String
    public var name: String
    public var nodeIp: String
    public var nodeStatus: Bool
    public var roomId: String
    public var status: Bool
}
