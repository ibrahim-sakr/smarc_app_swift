//
//  UserProtocol.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

protocol UserProtocol {
    func index()
    func find(id: String)
    func update(id: String, user: User)
    func delete(id: String)
}
