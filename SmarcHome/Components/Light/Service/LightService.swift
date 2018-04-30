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

class LightService: IntegrateSocketProtocol, RefreshableProtocol {

    static let instance = LightService();
    
    var VC: UpgradableList!

    public private(set) var points: [LightPoint] = [] {
        // run before points changed
        willSet(newValue) {}

        // run after the points changed
        didSet(newValue) {
            self.VC.updateList()
        }
    }

    func all(completion: @escaping CompletionHandler) -> Void {
        if self.points.count > 1 {
            completion(true)
            return
        }
        Alamofire.request(LightConst.INDEX_URL, method: .get, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    self.points = try! JSONDecoder().decode([LightPoint].self, from: data)
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    func toggle(point: LightPoint, completion: @escaping CompletionHandler) -> Void {
        Alamofire.request(LightConst.TOGGLE_URL + point._id, method: .get, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    let dataJSON = try! JSON(data: data)

                    if let i = self.points.index(where: { $0._id == dataJSON["_id"].stringValue }) {
                        // update it
                        self.points[i].status = dataJSON["status"].boolValue
                    }
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }

    /**
     * this method recieved any Light data comes from SocketIO to handle it
     */
    func notify(data: JSON) {
        let _id = data["_id"].stringValue
        // select from self.points where 'id' = data["id"].string
        if let i = self.points.index(where: { $0._id == _id }) {
            // update it
            self.points[i].status = data["status"].boolValue
        }
    }

    func refresh(complete: @escaping CompletionHandler) {
        self.points = []
        self.all { (success) in
            if success {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
    
}
