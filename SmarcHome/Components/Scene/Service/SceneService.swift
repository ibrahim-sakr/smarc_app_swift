//
//  SceneService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/13/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import SwiftyJSON
import SQLite
import Alamofire

class SceneService {

    static let instance = SceneService();

    var VC: UpgradableList!
    var scene: Scene!
    var scenes: [Scene] = [] {
        didSet {
            self.VC.updateList()
        }
    }

    func all() {
        if self.scenes.count == 0 {
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")

            let scenes = Table("scenes")
            let stmt = try! DB.instance.db().prepare(scenes.select(id, name))
            var tempScenes: [Scene] = []

            for scene in stmt {
                var sceneModel = Scene()
                sceneModel.id = scene[id]
                sceneModel.name = scene[name]
                tempScenes.append(sceneModel)
            }

            self.scenes.append(contentsOf: tempScenes)
        }
    }

    func find(id: Int64) -> Void {
        let sceneId = Expression<Int64>("id")
        let name = Expression<String>("name")
        let points = Expression<String>("points")

        let scenes = Table("scenes")
        let scene = try! DB.instance.db().prepare(scenes.filter(sceneId == id))

        for scen in scene {
            self.scene = Scene()
            self.scene.id = scen[sceneId]
            self.scene.name = scen[name]
            self.scene.points = JSON(parseJSON: scen[points])
        }
    }

    func create() -> Void {
        let name = Expression<String>("name")
        let points = Expression<String>("points")

        let scenes = Table("scenes")
        self.scene.id = try! DB.instance.db().run(scenes.insert(name <- self.scene.name, points <- self.scene.points.description))

        self.scenes.append(self.scene)
    }

    func update() -> Void {
        // update scene name
        let sceneId = Expression<Int64>("id")
        let name = Expression<String>("name")
        let points = Expression<String>("points")

        let scenes = Table("scenes")
        let scene = scenes.filter(sceneId == self.scene.id)

        try! DB.instance.db().run(scene.update(name <- self.scene.name, points <- self.scene.points.description))

        // update in scenes
        if let index = self.scenes.index(where: { $0.id == self.scene.id }) {
            var temp = self.scene
            temp!.points = JSON()
            self.scenes[index] = temp!
        }
    }

    func delete(id: Int64) -> Void {
        let sceneId = Expression<Int64>("id")

        let scenes = Table("scenes")
        let scene = scenes.filter(sceneId == id)

        try! DB.instance.db().run(scene.delete())
        
        // delete from scenes
        if let index = self.scenes.index(where: { $0.id == id }) {
            self.scenes.remove(at: Int(exactly: index)!)
        }
    }

    func addPoint(point: Point) {
        self.scene.points[point.mongoId] = JSON(point.dictionary)
    }

    func removePoint(mongoId: String) {
        self.scene.points.dictionaryObject?.removeValue(forKey: mongoId)
    }

    func getPoint(mongoId: String) -> Point? {
        if self.scene.points[mongoId] != JSON.null {
            let point = try! JSONDecoder().decode(Point.self, from: self.scene.points[mongoId].rawData())

            return point
        }

        return nil
    }

    func updatePoint(point: Point) {
        self.scene.points[point.mongoId] = JSON(point.dictionary)
    }

    func run(id: Int64, completion: @escaping CompletionHandler) {
        let body: Parameters = self.scene.points.rawValue as! [String: Any]

        Alamofire.request(SceneConst.RUN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }

}
