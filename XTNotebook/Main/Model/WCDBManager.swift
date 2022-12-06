//
//  WCDBManager.swift
//  XTNotebook
//
//  Created by Li on 2022/7/29.
//

import UIKit
import WCDBSwift

fileprivate struct WCDBFilePath {
    
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!+"/UserDB.db"
    
}

class WCDBManager: NSObject {

    static let manager = WCDBManager()
    let dbFile = URL.init(fileURLWithPath: WCDBFilePath().filePath)
    var dataBase : Database?
    
    override init() {
        super.init()
        dataBase = createdDB()
    }

    func createdDB() -> Database {
        print(dbFile)
        return Database.init(withFileURL: dbFile)
    }
    
    func createdTable<T:TableCodable>(table:String,of type:T.Type) {
        do {
            try dataBase?.create(table: table, of: type)
        } catch let error {
            debugPrint("创建表错误 \(error.localizedDescription)")
        }
    }
    
    func insertDB<T:TableCodable>(object:[T], intotable table:String) {
        do {
            try dataBase?.insertOrReplace(objects: object, intoTable: table)
        } catch let error {
            debugPrint("插入表错误\(error.localizedDescription)")
        }
    }
    
    func qureyFromDB<T:TableDecodable>(tableName:String,cls cName: T.Type,where condition:Condition? = nil,orderBy orderList:[Order]? = nil) -> [T]? {
            
        do {
            let allObjects: [T] = try (dataBase?.getObjects(fromTable: tableName, where:condition, orderBy:orderList))!
            return allObjects
            
        }catch let error {
            debugPrint("查询错误\(error.localizedDescription)")
        }
        
        return nil
        
    }
    
    func updateFromDB<T:TableEncodable>(tableName:String,on propertys:[PropertyConvertible],with object:T,where condition:Condition? = nil) {
        do {
            try dataBase?.update(table: tableName, on: propertys, with: object, where: condition)
        } catch let error {
            debugPrint("更新错误\(error.localizedDescription)")
        }
    }
    
    func deleteFromDB(tableName:String,where condition:Condition?=nil) {
        do{
            try dataBase?.delete(fromTable: tableName ,where: condition)
        }catch let error {
            debugPrint("删除错误\(error.localizedDescription)")
        }
        
    }
    
}
