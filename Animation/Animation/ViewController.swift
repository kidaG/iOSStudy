//
//  ViewController.swift
//  Animation
//
//  Created by yuya on 2016/12/04.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewControlledByTimer: UIView!
    @IBOutlet weak var viewControlledByUIView: UIView!
    var timer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        if timer == nil{
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer:Timer) in
//                print("Timer:\(timer)")
                ViewController.move(self.viewControlledByTimer, with: 1, parentWidth: self.view.bounds.size.width)
            })
            timer.fire()
        }
        
        self.viewControlledByTimer.backgroundColor = UIColor.red
        self.viewControlledByUIView.backgroundColor = UIColor.green
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        UIView.animate(withDuration: 2.0, animations: {
            print("UIView.animate")
            self.self.viewControlledByUIView.center.x = self.view.bounds.size.width - self.viewControlledByUIView.bounds.width/2
        }){ (finished: Bool) -> Void in
            UIView.animate(withDuration: 2.0, animations: {
                print("UIView.animate")
                self.self.viewControlledByUIView.center.x = self.viewControlledByUIView.bounds.width/2
            })
        }
    }
    
    static private func move(_ view:UIView?, with:CGFloat, parentWidth:CGFloat){
        guard let view = view else{
            print("Not configure yet")
            return
        }
        view.center = CGPoint(x: view.center.x + 1, y: view.center.y)
        if (view.center.x > parentWidth) {
            view.center = CGPoint(x:0, y:view.center.y)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

