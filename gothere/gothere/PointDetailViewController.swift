//
//  PointDetailViewController.swift
//  gothere
//
//  Created by Stepan Trofimov on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

class PointDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var viewUnderDescription: UIView
    
    @IBOutlet var titlePointLabel: UILabel
    @IBOutlet var descriptionTextField: UITextView
    @IBOutlet var buttonHello: UIButton
    @IBOutlet var imageView: UIImageView
    
    let  alphaBeforeShow = 0.0 as CGFloat
    
    let alphaAfterShow = 1.0 as CGFloat
    let duration  = 0.50
    
    var imageData : NSData = NSData()
    var storyId = ""
    var titlePoint = ""
    var descriptionPoint = ""
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage()
        println("\(storyId)")
        
        

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
         println("\(storyId)")
        BackendClient.instance.getStory(storyId, completionBlock: { (point: Point?, error: NSError?) -> () in
                        if point {
                            NSLog("%@", point.description)
                            self.descriptionPoint = "\(point!.about)"
                            self.titlePoint = "\(point!.pointTitle)"
                            self.imageName = "\(point!.pointURL)"
                            var err: NSError?
                            var  url = NSURL.URLWithString(self.imageName)
                            self.imageData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                                // do some async stuff
                                NSOperationQueue.mainQueue().addOperationWithBlock {
                                    self.imageView.image = UIImage(data: self.imageData)
                                    self.descriptionTextField.text = self.descriptionPoint
                                    self.titlePointLabel.text = self.titlePoint
                                }
                            }
                            
                        }
                        else {
                            NSLog("%@", error.description)
                        }
                    })
        
        
        
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
  
    @IBAction func takePhotoTapped(sender: AnyObject) {
        return;
//        var picker: UIImagePickerController = UIImagePickerController()
//        picker.delegate = self;
//            
//        // creating overlayView
//        var overlayView: UIImageView = UIImageView(frame:picker.view.frame)
//        // letting png transparency be
//        overlayView.image = UIImage(named:"routeTableRowBack")
//        overlayView.layer.opaque = false
//        overlayView.opaque = false
//        
//        picker.showsCameraControls = true; // NO
//        picker.cameraOverlayView = overlayView;
//        picker.sourceType = UIImagePickerControllerSourceType.Camera;
//        self.presentModalViewController(picker, animated: true)
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
    
    

    // UIImagePickerController delegate methods stubs
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        // stub
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        // stub
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        // stub
    }
    
    // UINavigationControllerDelegate to be implemented
}
