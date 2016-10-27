//
//  ViewController.swift
//  MyDictionaryApps
//
//  Created by yuya on 2015/11/19.
//  Copyright © 2015年 yuya. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, LTMorphingLabelDelegate{

    @IBOutlet weak var appName: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appName.text = "私の辞書"
        self.appName.morphingEffect = .Fall
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

