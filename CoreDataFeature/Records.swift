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
    
    /// オリジナルの初期化。これで作成された変数はDBに登録される
    /// 注意：一時的にmanagedObjectContextに保存されるが、saveContextをしていないため、実際にDBには書き込まれないことに注意する必要あり。
    init(tableName:String, isSave:Bool){
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
    
    class func fetchAllRecords(tableName:String) -> [Records]{
        var records:[Records] = []
        if let context = Records.appDelegate?.managedObjectContext {
            let entityDiscription = NSEntityDescription.entityForName(tableName, inManagedObjectContext: context)
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entityDiscription
            
            if let results = try! context.executeFetchRequest(fetchRequest) as? [Records] {
                records = results
            }
        }
        return records
    }
    
    static func deleteAllRecords(){
        
        if let context = Records.appDelegate?.managedObjectContext {
            let entityDiscription = NSEntityDescription.entityForName(Constant.TableName, inManagedObjectContext: context)
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entityDiscription
            
            if let results = try! context.executeFetchRequest(fetchRequest) as? [Teams] {
                let teams = results
                
                for team in teams{
                    context.deleteObject(team)
                }
                
                Records.appDelegate?.saveContext()
            }
        }
    }
    
    // appDelegateへの変更点をすべてDBに反映するための関数
    func updateToDB(){
        Records.appDelegate?.saveContext()
    }
    
    /// サブクラスで実装される
    class func getTableName() -> String{
        fatalError("This method should be overrided")
    }

}