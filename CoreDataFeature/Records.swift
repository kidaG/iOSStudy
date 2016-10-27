//
//  Records.swift
//  CoreDataFeature
//
//  Created by yuya on 2016/01/10.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class Records: NSManagedObject {

    // AppDelegateクラスのインスタンスを取得
    static let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    
    init(){
        fatalError()
    }
    
    /// - parameter isSave: Trueの場合はappDelegateにデータを保存する。Falseの場合はどこにも保存されない。
    required init(tableName:String, isSave:Bool = true){
        if let context = Records.appDelegate?.managedObjectContext {
            if let entity = NSEntityDescription.entityForName(tableName, inManagedObjectContext: context){
                super.init(entity: entity, insertIntoManagedObjectContext: (isSave ? context : nil))
            }else{
                fatalError("entity is Nothing for \(tableName) and context")
            }
        }else{
            fatalError("mangaedContext is Nothing in AppDelegate")
        }
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    /// サブクラスのレコードを作成するファクトリー関数
    class func createNewRecord(isSave:Bool = true) -> Self{
        return self.init(tableName:self._getTableName(), isSave:isSave)
    }
    

    /// すべてのレコードを削除する
    static func deleteAllRecords(){
        if let context = Records.appDelegate?.managedObjectContext {
            let entityDiscription = NSEntityDescription.entityForName(_getTableName(), inManagedObjectContext: context)
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entityDiscription
            if let results = try! context.executeFetchRequest(fetchRequest) as? [Records] {
                for result in results{
                    context.deleteObject(result)
                }
                Records.appDelegate?.saveContext()
            }
        }
    }
    
    // appDelegateへの変更点をすべてDBに反映するための関数
    func updateToDB(){
        Records.appDelegate?.saveContext()
    }
    
    
    /// protected
    static func _fetchAllRecords() -> [Records]{
        var records:[Records] = []
        if let context = Records.appDelegate?.managedObjectContext {
            let entityDiscription = NSEntityDescription.entityForName(self._getTableName(), inManagedObjectContext: context)
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entityDiscription
            
            if let results = try! context.executeFetchRequest(fetchRequest) as? [Records] {
                records = results
            }
        }
        return records
    }
    
    /// サブクラスで実装される
    class func _getTableName() -> String{
        fatalError("This method should be overrided")
    }

}