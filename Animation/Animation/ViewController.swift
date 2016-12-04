//
//  ViewController.swift
//  Animation
//
//  Created by yuya on 2016/12/04.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate{

    @IBOutlet weak var viewControlledByTimer: UIView!
    @IBOutlet weak var viewControlledByUIView: UIView!
    @IBOutlet weak var viewControlledByCoreAnimation: UIView!
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
        self.viewControlledByCoreAnimation.backgroundColor = UIColor.blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
        ViewController.animationByUIKit(with: viewControlledByUIView, parentView: self.view)
        
        ViewController.animationByCABasicAnimation(self.viewControlledByCoreAnimation, delegate:self)
    }
    
    /// Timerによるアニメーション
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
    
    /// UIKitによるアニメーション
    static private func animationByUIKit(with: UIView?, parentView: UIView){
        
        guard let view = with else{
            print("Not Initilized")
            return
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            print("UIView.animate")
            view.center.x = parentView.bounds.size.width - view.bounds.width/2
        }){ (finished: Bool) -> Void in
            UIView.animate(withDuration: 2.0, animations: {
                print("UIView.animate")
                view.center.x = view.bounds.width/2
            })
        }
    }
    
    
    
    static private func animationByCABasicAnimation(_ view:UIView?, delegate:CAAnimationDelegate)
    {
        guard let view = view else{
            print("Not Initilized")
            return
        }
        
        // cornerRadiusを変更するアニメーション
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        
        // cornerRadius を 0 -> 100 に変化させるよう設定
        cornerRadiusAnimation.fromValue = 0
        cornerRadiusAnimation.toValue = 100
        
        // アニメーション
        cornerRadiusAnimation.duration = 2.0
        
        // アニメーションが終了した時の状態を維持する
        cornerRadiusAnimation.isRemovedOnCompletion = true
        cornerRadiusAnimation.fillMode = kCAFillModeForwards
        
        // アニメーションが終了したらanimationDidStopを呼び出す
        cornerRadiusAnimation.delegate = delegate
        
        // アニメーションの追加
        view.layer.add(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        print("animationDidStop:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

