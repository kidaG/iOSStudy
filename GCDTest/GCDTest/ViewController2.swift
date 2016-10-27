//
//  ViewController.swift
//  GCDTest
//
//  Created by Yuya Kida on 2016/06/01.
//  Copyright © 2016年 FujiXerox. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

//    private let oneQueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL)
    
    @IBOutlet weak var label: UILabel!
    
    deinit{
        print("ViewController2 - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController2 - viewDidLoad")
        label.text = "viewDidLoad"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func clickOnButton(sender: UIButton) {
        
        label.text = "clickOnButton"
        
        let didCancel = {(tag:String) -> () in
            print("Cancel:" + tag)
        }
        let gcd = ZGcd(cancelProcess:didCancel)
        let gcd2 = ZGcd(cancelProcess:didCancel)
        let gcdConcurrent = ZGcd(queue: dispatch_queue_create("CustomizedQueue", DISPATCH_QUEUE_CONCURRENT), cancelProcess:didCancel)
        
        gcd.start("TAG1"){[weak self] in
//            print(GCD.detectQueueLabel())
            print("dispatch_async1 start")
            sleep(5)
            print("dispatch_async1 fin")
            ZGcd.main{
                self?.label.text = "dispatch_async1"
            }
        }
        
        gcd.start("TAG2.1"){[weak self] in
            print("dispatch_async2.1 start")
//            sleep(2)
            print("dispatch_async2.1 fin")
            ZGcd.main{
                self?.label.text = "dispatch_async2.1"
            }
        }
        
        gcd.start("TAG2.2"){[weak self] in
            print("dispatch_async2.2 start")
            //            sleep(2)
            print("dispatch_async2.2 fin")
            ZGcd.main{
                self?.label.text = "dispatch_async2.2"
            }
        }
        
        gcd2.start("TAG3"){[weak self] in
            print("dispatch_async3 start")
            sleep(2)
            print("dispatch_async3 fin")
            ZGcd.main{
                self?.label.text = "dispatch_async3"
            }
            
        }
        
        gcdConcurrent.start("TAG4"){
            print("dispatch_async4 start")
            sleep(3)
            print("dispatch_async4 fin")
        }
        
        print(ZGcd.detectQueueLabel())
        print(gcd.getCurrentQueueLabel())
        
        sleep(1)
        gcd.cancel()
    }

    
    
    
}





class ZGcd{
    // プライベートキューの発行。
    private static let private_queue:dispatch_queue_t! = dispatch_queue_create("jp.test.sample", DISPATCH_QUEUE_SERIAL);
    
    deinit{
        print("GCD deinit:\(tag)")
        isCancel = true
    }
    
    private var isCancel:Bool
    private let cancelProcess:((tag:String)->())?
    weak private var queue:dispatch_queue_t?
    
    private var tag:[String] = []
    
    /// queueを指定しないとGCDクラスの静的変数（シリアルキュー）を利用する
    /// cancelProcessを渡すと、キャンセル(cancel()呼ばれた)時に代わりにこの関数が呼ばれる
    init(queue:dispatch_queue_t? = nil, cancelProcess:((tag:String)->())? = nil){
        isCancel = false
        self.cancelProcess = cancelProcess
        
        if let queue = queue{
            self.queue = queue
        }else{
            self.queue = ZGcd.private_queue
        }
    }
    
    /// キューに待機中の処理をキャンセルする。即座に中止するのではなく、引数の関数を呼び出す代わりにcancelProcessが呼び出される。
    func cancel(){
        isCancel = true
    }
    
    func start(tag:String = "GCD", f:() -> ()){
        self.tag.append(tag)
        guard let queue = self.queue else{
            print("queue is null")
            return}
        dispatch_async(queue){
            // Backgroundで行いたい重い処理はここ
            if self.isCancel{
                self.cancelProcess?(tag: tag)
            }else{
                f()
            }
        }
    }
    
    /// Queueのラベルを取得する(デバッグ用)
    func getCurrentQueueLabel() -> String{
        let label = dispatch_queue_get_label(queue)
        return String(format: "%s", label)
    }
    
    /// If the thread is main thread, f() function is executed just. If not, this method calls dispatch_get_main_queue and f() function will be executed on MainThread. That is, this method ensures f() is executed on MainThread.
    /// - parameter f(): This method is exuceted on MainThread certainly.
    static func main(f:() -> ()){
        if NSThread.isMainThread(){
            f()
        }else{
            let main = dispatch_get_main_queue()
            dispatch_async(main, {
                f()
            })
        }
    }
    
    /// このメソッドを呼び出したQueueのラベルを取得する(デバッグ用)
    static func detectQueueLabel() -> String{
        let label = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)
        return String(format: "%s", label)
    }
}
