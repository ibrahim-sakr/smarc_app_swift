//
//  Point.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

struct LightPoint: Decodable {
    public private(set) var _id: String;
    public private(set) var name: String;
    public private(set) var nodeIp: String;
    public private(set) var nodeName: String;
    public private(set) var nodeStatus: Bool;
    public private(set) var roomId: String;
    public var status: Bool;
}
