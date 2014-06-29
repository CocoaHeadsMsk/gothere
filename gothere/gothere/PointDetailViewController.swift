//
//  PointDetailViewController.swift
//  gothere
//
//  Created by Stepan Trofimov on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

class PointDetailViewController: UIViewController {

    @IBOutlet var viewUnderDescription: UIView
    
    @IBOutlet var descriptionTextField: UITextView
    @IBOutlet var buttonHello: UIButton
    @IBOutlet var imageView: UIImageView
    
    let  alphaBeforeShow = 0.0 as CGFloat
    
    let alphaAfterShow = 1.0 as CGFloat
    let duration  = 0.50
    
    var storyId = ""
    var titlePoint = ""
    var descriptionPoint = ""
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named:"1.jpg")
        
        println("\(storyId)")


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("\(storyId)")

        BackendClient.instance.getStory(storyId, completionBlock: { (point: Point?, error: NSError?) -> () in
                        if point {
                            NSLog("%@", point.description)
                            self.descriptionPoint = "\(point!.about)"
                            self.titlePoint = "\(point!.pointTitle)"
                            self.imageName = "\(point!.pointURL)"
                            
                            
                        }
                        else {
                            NSLog("%@", error.description)
                        }
                    })
        var err: NSError?
        var  url = NSURL.URLWithString(self.imageName)
        var imageData :NSData = NSData.dataWithContentsOfURL(url,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
        imageView.image = UIImage(data: imageData)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedOn(sender: UITapGestureRecognizer) {
        
        self.viewUnderDescription.hidden = !self.viewUnderDescription.hidden

        UIView.animateWithDuration(duration, {
            self.viewUnderDescription.alpha = self.alphaAfterShow
            }, completion: {
                (value: Bool) in
                
            })
            
        
        
    }
  

    @IBAction func buttonHelloAction(sender: UIButton) {
        println("Hello!")
    }
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backTapped(sender: AnyObject) {
        self.navigationController.popViewControllerAnimated(true)
        println("\(storyId)")

        
    }
    
    

}
