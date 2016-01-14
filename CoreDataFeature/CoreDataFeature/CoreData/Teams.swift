//
//  Team.swift
//  CoreDataFeature
//
//  Created by yuya on 2015/11/16.
//  Copyright © 2015年 yuya. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Teams: Records {
    
    struct Constant{
        static let TableName = "Teams"
    }
    
    /// テーブル名を返す
    override class func getTableName() -> String{
        return Constant.TableName
    }
    
    
    /// オリジナルの初期化。これで作成された変数はDBに登録される
    /// 注意：一時的にmanagedObjectContextに保存されるが、saveContextをしていないため、実際にDBには書き込まれないことに注意する必要あり。
    init(isSave:Bool = true){
        super.init(tableName: Constant.TableName, isSave: isSave)
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    static func createRecord(name:String, id:Int) -> Teams?{
        let team:Teams = Teams()
        team.name = name
        team.teamId = id
        team.updateToDB()
        return team
    }
    
    
    static func fetchAllRecords() -> [Teams]{
        
        if let teams = Records.fetchAllRecords(Constant.TableName) as? [Teams]
        {
            return teams
        }else{
            return []
        }
    }
}


