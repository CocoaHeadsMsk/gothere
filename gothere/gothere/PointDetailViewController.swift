//
//  PointDetailViewController.swift
//  gothere
//
//  Created by Stepan Trofimov on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

class PointDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var buttonHello: UIButton
    @IBOutlet var imageView: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named:"1.jpg")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedOn(sender: UITapGestureRecognizer) {
        buttonHello.hidden = !buttonHello.hidden;
        
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
