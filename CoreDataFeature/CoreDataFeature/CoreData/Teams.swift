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
    
    //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ Please copy the following to other class inheriting Records↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    
    /// protected - テーブル名を返す
    override class func _getTableName() -> String{
        return Constant.TableName
    }
    
    /// Created Instance is saved to DB after calling updateToDB() method
    override convenience init(){
        self.init(isSave:true)
    }
    
    /// You can control whether you will save the initialized instance or not by the following parameter:
    /// - parameter isSave:
    init(isSave:Bool){
        super.init(tableName: Constant.TableName, isSave: isSave)
    }
    
    /// Not Recommend to use this initializer
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    /// Not Recommend to use this initializer
    required init(tableName: String, isSave: Bool = true) {
        super.init(tableName: tableName, isSave: isSave)
    }
    

    //↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ Please copy the above to other class inheriting Records ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
    
    
    static func fetchAllRecords() -> [Teams]{
        if let records = self._fetchAllRecords() as? [Teams]{
            return records
        }else{
            return []
        }
    }
    
}


