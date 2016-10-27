//
//  ViewController.swift
//  MemoryMangement
//
//  Created by yuya on 2016/01/19.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class SinglePageViewController: UIViewController {
    
    
    deinit{
        print("deinit - SinglePageViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("       view DidLoad - SinglePageViewController")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onHideButton(sender: AnyObject) {
        print("onHideButton")
        
        if self.tabBarController?.tabBar.hidden == false{
            self.tabBarController?.tabBar.hidden = true
        }else{
            self.tabBarController?.tabBar.hidden = false
        }
    }
    
}

