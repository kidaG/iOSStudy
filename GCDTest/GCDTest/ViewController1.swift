//
//  ViewController2.swift
//  GCDTest
//
//  Created by Yuya Kida on 2016/06/01.
//  Copyright © 2016年 FujiXerox. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    deinit{
        print("ViewController1 - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController1 - viewDidLoad")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
