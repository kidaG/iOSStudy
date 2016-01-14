//
//  AddTeamViewController.swift
//  CoreDataFeature
//
//  Created by yuya on 2015/11/17.
//  Copyright © 2015年 yuya. All rights reserved.
//

import UIKit

class AddTeamViewController: UIViewController {

    @IBOutlet weak var teamNameField: UITextField?
    @IBOutlet weak var teamIdField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTeamButton(sender: AnyObject) {
        print("addTeamButton - start")
        
        let teamName = teamNameField?.text
        let teamId = teamIdField?.text
        
        
        print(String(teamName) + " - " + String(teamId))
        
        if(teamName == "" || teamId == ""){
            print("Fail")
            return
        }
 
        guard let id = Int(teamId!) else{
            print("Fail")
            return
        }
        let team = Teams()
        team.teamId = id
        team.name = teamName
        team.updateToDB()
        print("addTeamButton - fin")
    }

    @IBAction func seeButton(sender: AnyObject) {
        print("seeButton - start")
        Teams.fetchAllRecords()
        print("seeButton - end")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
