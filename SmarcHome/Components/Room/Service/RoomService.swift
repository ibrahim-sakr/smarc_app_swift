//
//  RoomService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/12/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class RoomService {
    
    static let instance = RoomService()

    public private(set) var rooms: [Room] = [Room]()

    func all(completion: @escaping CompletionHandler) {
        if self.rooms.count > 1 {
            completion(true)
            return
        }
        Alamofire.request(RoomConst.INDEX_URL, method: .get, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON { (response) in
                
                if response.result.error == nil {
                    guard let data = response.data else { return };
                    
                    self.rooms = try! JSONDecoder().decode([Room].self, from: data);
                    completion(true);
                } else {
                    completion(false);
                }
        }
    }

}
