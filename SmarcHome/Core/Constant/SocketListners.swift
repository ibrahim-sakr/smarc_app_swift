//
//  SocketListners.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

let SocketListners: [String: IntegrateSocketProtocol] = [
    "user": UserService.instance,
//    "siren": "",
//    "security": "",
//    "scene": "",
//    "room": "",
//    "music": "",
//    "motor": "",
    "light": LightService.instance,
//    "door": "",
//    "cam": ""
]
