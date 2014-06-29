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
    
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named:"1.jpg")
        println("\(id)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedOn(sender: UITapGestureRecognizer) {
//        var descriptionTextView = UITextView()
//        var bacgroundColor = [UIColor.color]
//        descriptionTextView.backgroundColor = [UIColor blackcolor];
//        descriptionTextView.backgroundColor.
        viewUnderDescription.alpha = alphaBeforeShow
        viewUnderDescription.hidden = !viewUnderDescription.hidden
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
        
    }

}
