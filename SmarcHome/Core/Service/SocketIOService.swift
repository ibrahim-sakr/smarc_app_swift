//
//  SocketIOService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/8/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON

class SocketIOService: NSObject {
    static let instance = SocketIOService()

    private let manager = SocketManager(socketURL: URL(string: CoreConst.BASE_SOCKET_URL)!, config: [.log(true), .compress])
    private var socket: SocketIOClient

    override init() {
        self.socket = self.manager.defaultSocket
        super.init()
    }
    
    func connect() -> Void {
        print("connecting to socket io")
        // connect to socket server
        self.socket.connect()
        
        // start listing for events
        self.registerEvents()
    }

    func close() -> Void {
        self.socket.disconnect()
    }

    func registerEvents() {
        self.socket.on(CoreConst.SOCKET_INCOME_DATA) { (dataArray, ack) in
            // extract needed variables
            let income = dataArray[0] as! [String: Any]

            // get type as string
            let type = income["type"] as! String

            // cast the data to it's type class
            if SocketListners[type] != nil {

                // get data as string
                let dataAsString = income["data"].debugDescription

                // convert data to type JSON
                let dataAsJSON = JSON(stringLiteral: dataAsString)

                SocketListners[type]?.notify(data: dataAsJSON)
            }
        }
    }

}