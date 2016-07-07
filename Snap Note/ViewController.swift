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
        // Do any additional setup after loading the view, typically from a nib.
        
        //
        
        var cameraView : CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        
        var listNotesTableView : ListNotesTableViewController = ListNotesTableViewController(nibName: "ListNotesTableViewController", bundle: nil)
        

        
        var listTwo : ListTwoTableViewController = ListTwoTableViewController(nibName: "ListTwoTableViewController", bundle: nil)
        
        
        
        self.addChildViewController(cameraView)
    self.scrollView.addSubview(cameraView.view)
        cameraView.didMoveToParentViewController(self)
        
        
        self.addChildViewController(listNotesTableView)
        self.scrollView.addSubview(listNotesTableView.view)
        listNotesTableView.didMoveToParentViewController(self)

        self.addChildViewController(listTwo)
        self.scrollView.addSubview(listTwo.view)
        listTwo.didMoveToParentViewController(self)
        
        var cameraFrame : CGRect = cameraView.view.frame
        cameraFrame.origin.x = self.view.frame.width
        cameraView.view.frame = cameraFrame
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.size.height)
        self.scrollView.contentOffset = CGPoint(x: cameraFrame.origin.x, y: cameraFrame.origin.y)
    }
    
        
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}

