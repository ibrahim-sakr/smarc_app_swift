//
//  UserConst.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation


class UserConst {
    static var INDEX_URL: String {
        return "\(CoreConst.BASE_API_URL)/user"
    }
    
    static let ACTION_DELETE = "delete"
    static let ACTION_UPDATE = "update"
    static let ACTION_SHEET_MESSAGE = "What do you need to do"
    static let ACTION_SHEET_EDIT = "edit"
    static let ACTION_SHEET_DELETE = "delete"
    static let ACTION_SHEET_CANCEL = "cancel"
    static let SEGUE_TO_EDIT_USER = "toEditUser"
}
