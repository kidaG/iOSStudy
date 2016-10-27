//
//  PageViewController.swift
//  MemoryMangement
//
//  Created by yuya on 2016/01/20.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    
    static let Controllerid = "SinglePageViewControllerId"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad() - PageViewController")
        
        
        
        let startingViewController = self.storyboard?.instantiateViewControllerWithIdentifier(PageViewController.Controllerid) as? SinglePageViewController
        let viewControllers = [startingViewController!]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in})
        
        self.dataSource = self
        
        
        //ページコントロール（色を変更する）
        let pageControl:UIPageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
            let startingViewController = self.storyboard?.instantiateViewControllerWithIdentifier(PageViewController.Controllerid) as? SinglePageViewController
            return startingViewController
            
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        let startingViewController = self.storyboard?.instantiateViewControllerWithIdentifier(PageViewController.Controllerid) as? SinglePageViewController
        return startingViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int // The number of items reflected in the page indicator.
    {
        return 10
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int // The selected item reflected in the page indicator.
    {
        return 4
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
