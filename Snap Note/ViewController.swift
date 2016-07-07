//
//  ViewController.swift
//  Snap Note
//
//  Created by King Justin on 7/6/16.
//  Copyright © 2016 justinleesf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .greenColor()
        
        let cameraView : CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        
        let one : ListNotesTableViewController = ListNotesTableViewController(nibName: "ListNotesTableViewController", bundle: nil)
        
        let two : ListTwoTableViewController = ListTwoTableViewController(nibName: "ListTwoTableViewController", bundle: nil)
//        let two = self.storyboard?.instantiateViewControllerWithIdentifier("ListTwoTableViewController") as! ListTwoTableViewController
        
        self.scrollView.bounces = false
        
        
        self.addChildViewController(cameraView)
        self.scrollView.addSubview(cameraView.view)
        cameraView.didMoveToParentViewController(self)
        
        self.addChildViewController(one)
        self.scrollView.addSubview(one.view)
        one.didMoveToParentViewController(self)
        
        self.addChildViewController(two)
        self.scrollView.addSubview(two.view)
        two.didMoveToParentViewController(self)
        
        var cameraFrame : CGRect = cameraView.view.frame
        cameraFrame.origin.x = self.view.frame.width
        cameraView.view.frame = cameraFrame
        
        two.view.frame = CGRectMake(2*self.view.frame.width, 0, two.view.frame.size.width, two.view.frame.size.height)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.size.height)
//        self.scrollView.contentOffset = CGPoint(x: cameraFrame.origin.x, y: cameraFrame.origin.y)
    }
    
        
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}

