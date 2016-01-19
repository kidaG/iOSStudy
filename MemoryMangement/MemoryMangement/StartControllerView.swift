//
//  ViewController.swift
//  MemoryMangement
//
//  Created by yuya on 2016/01/19.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class StartControllerView: UIViewController {
    
    let test = Test2()
    class Test2{
        init(){
            print("init - test2")
        }
        deinit{
            print("deinit - test2")
        }
    }
    deinit{
        print("deinit - StartControllerView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("       view DidLoad - StartControllerView")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("       prepareForSegue - StartControllerView")
    }
    
    @IBAction func firstViewReturnActionForSegue(segue:UIStoryboardSegue){
        print("First view return action invoked.");
    }
}

