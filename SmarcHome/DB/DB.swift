//
//  DB.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/15/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import SQLite


// connect to DB
// check version
//    if matched then return DB
//    if NOT matched
//        run migration
//        return DB

class DB {
    static let instance = DB()

    private var database: Connection!

    func db() -> Connection {
        if self.database != nil {
            return self.database
        }

        // connect to DB
        self.connect()
        return self.database
    }
    
    private func connect() -> Void {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! + "/" + Bundle.main.bundleIdentifier!
        
        // create parent directory if it doesn’t exist
        try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        
        self.database = try! Connection("\(path)/database.sqlite3")

        // check version
        let db_version: Float = self.checkVersion()

        if db_version < DBConst.DB_VERSION {
            // update DB version
            self.updateDBVersion()
            // run DB migration
            self.runMigration()
        } else if db_version > DBConst.DB_VERSION {
            // downgrade DB version
            self.updateDBVersion()
            // run DB migration
            self.runDowngradeMigration()
        }
    }
    
    private func checkVersion() -> Float {
        print("========================")
        print("Check DB Version")
        print("========================")
        do {
            let res = try self.database.scalar("SELECT value FROM \(DBConst.OPT_TABLE) WHERE key='version'")
            print("========================")
            print("DB Version")
            print((res as! NSString).floatValue)
            print("========================")

            return (res as! NSString).floatValue
        } catch {
            print("========================")
            print("Errors => DB Not Prepared yet")
            print("========================")
            // table not exist then we initaite the DB sceme from scratch
            self.initDBSceme()
            return 0.0
        }
    }
    
    private func updateDBVersion() {
        try! self.database.run("UPDATE \(DBConst.OPT_TABLE) SET value = '\(DBConst.DB_VERSION)' WHERE key = 'version'")
    }

    private func initDBSceme() -> Void {
        print("========================")
        print("Preparing DB")
        print("========================")
        do {
            try self.database.execute("""
                CREATE TABLE \(DBConst.OPT_TABLE) (id INTEGER PRIMARY KEY NOT NULL, key TEXT UNIQUE NOT NULL, value TEXT);
                INSERT INTO \(DBConst.OPT_TABLE) (key, value) VALUES ('version', '0.0')
            """)
        } catch {
            print("========================")
            print("Failed To Prepare DB")
            print("========================")
        }
    }

    private func runMigration() -> Void {
        print("===================")
        print("Migration Running")
        print("===================")

        // create scene table
        self.createSceneTable()
    }
    
    private func runDowngradeMigration() -> Void {
        print("===================")
        print("Downgrade Migration Running")
        print("===================")

        self.dropTables()
    }
    
    private func dropTables() {
//        try! self.database.run("DROP TABLE options")
        try! self.database.run("DROP TABLE scenes")
        try! self.database.run("DROP TABLE scene_details")
    }

    private func createSceneTable() {
        let scenes = Table("scenes")

        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let points = Expression<String>("points")

        try! self.database.run(scenes.create { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(name)
            t.column(points)
        })
    }

}
