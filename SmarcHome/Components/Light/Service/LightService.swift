//
//  LightService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import Alamofire;
import SwiftyJSON;

class LightService: IntegrateSocketProtocol {
    
    static let instance = LightService();
    
    public private(set) var points: [Point] = [Point]()
    
    func notify(data: JSON) {
        print("===============================")
        print("Light Data")
        print(data)
        print("===============================")
    }
}
