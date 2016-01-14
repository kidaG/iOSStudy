//
//  Team+CoreDataProperties.swift
//  CoreDataFeature
//
//  Created by yuya on 2015/11/16.
//  Copyright © 2015年 yuya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Teams {

    @NSManaged var teamId: NSNumber?
    @NSManaged var name: String?
    @NSManaged var user: Users?

}
