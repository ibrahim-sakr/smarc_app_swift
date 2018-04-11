//
//  IntegrateSocketProtocol.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/11/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol IntegrateSocketProtocol {
    func notify(data: JSON)
}
