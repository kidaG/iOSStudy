//
//  ViewController.swift
//  MemoryMangement
//
//  Created by yuya on 2016/01/19.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController {

    
    deinit{
        print("deinit - Tab1ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("       view DidLoad - Tab1ViewController")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

