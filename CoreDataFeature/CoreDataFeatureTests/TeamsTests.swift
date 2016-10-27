//
//  TeamsTests.swift
//  CoreDataFeature
//
//  Created by yuya on 2016/01/10.
//  Copyright © 2016年 yuya. All rights reserved.
//

import XCTest
@testable import CoreDataFeature
class TeamsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testFetchAllData() {
        let teams = Teams.fetchAllRecords()
        XCTAssertNotNil(teams)
        print("count: \(teams.count)")
        for team in teams{
            print(String(team.name) + ":" + String(team.teamId))
        }
    }
    
    func testInit(){
        print("count: \(Teams.fetchAllRecords().count)")
        let team:Teams? = Teams()
        team?.name = "test1"
        team?.updateToDB()
        print("count: \(Teams.fetchAllRecords().count)")
    }
    
    func testCreateRecord() {
        let team = Teams.createNewRecord()
        team.name = "CreateRecord" + String(NSDate())
        team.teamId = 1
        team.updateToDB()
    }
    
    func testCreateRecord2() {
        let count = Teams.fetchAllRecords().count
        let team = Teams.createNewRecord()
        team.name = "CreateRecord" + String(NSDate())
        team.teamId = 2
        team.updateToDB()
        XCTAssertNotNil(team)
        print(team)
        
        XCTAssertEqual(count, Teams.fetchAllRecords().count - 1)
    }
    
    func testDeleteAllRecords(){
        let countBefore = Teams.fetchAllRecords().count
        Teams.deleteAllRecords()
        let countAfter = Teams.fetchAllRecords().count
        
        XCTAssertEqual(countAfter, 0)
        
        print("\(countBefore) -> \(countAfter)")
    }
   
    
}
