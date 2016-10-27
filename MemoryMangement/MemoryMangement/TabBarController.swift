//
//  TabBarController.swift
//  MemoryMangement
//
//  Created by yuya on 2016/01/19.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    deinit{
        print("deinit - TabBarController")
    }
    let test = Test()
    class Test{
        init(){
        
        }
        deinit{
            print("deinit - test")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("       view DidLoad - TabBarController - " + String(test))
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
