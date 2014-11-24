//
//  ViewController.swift
//  Currency
//
//  Created by John Holdsworth on 21/11/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var viewToGroup: UIView!
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cg = getCGContextForFrames()

        // here is where the grouping is done
        var id: Int = 10
        let iWatchAvailableArea38mm = CGRectMake(0.0, 0.0, 268.0, 302.0)
        let iWatchAvailableArea42mm = CGRectMake(0.0, 0.0, 308.0, 352.0)
        Group.group( self, frame:iWatchAvailableArea42mm,
            subviews:viewToGroup.subviews, id:&id, cg: cg )

        if true {
            let image = CGBitmapContextCreateImage(cg)
            let uiImage = UIImage(CGImage:image)
            imageView.image = uiImage
            let data = UIImagePNGRepresentation(uiImage);
            data.writeToFile("/tmp/frames.png", atomically: false);
        }

        if true {
            UIGraphicsBeginImageContext(viewToGroup.frame.size);
            viewToGroup.layer.renderInContext(UIGraphicsGetCurrentContext());
            let image = UIGraphicsGetImageFromCurrentImageContext();
            let data = UIImagePNGRepresentation(image);
            data.writeToFile("/tmp/background.png", atomically: false);
            UIGraphicsEndImageContext();
        }

    }

    func getCGContextForFrames() -> CGContext {
        let rect = viewToGroup.bounds
        let bitsPerComponent = 8, bytesPerRow = bitsPerComponent/8*4 * Int(rect.size.width)
        let memory = calloc( UInt(bytesPerRow * Int(rect.size.height)), UInt(1) )
        let cg = CGBitmapContextCreate(memory,
            UInt(rect.size.width), UInt(rect.size.height),
            UInt(bitsPerComponent), UInt(bytesPerRow), CGColorSpaceCreateDeviceRGB(),
            CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue))

        CGContextScaleCTM(cg, 1.0, -1.0)
        CGContextTranslateCTM(cg, 0.0, -rect.size.height)

        var white: [CGFloat] = [1.0, 1.0, 1.0, 1.0]
        CGContextSetFillColor(cg, white)
        CGContextFillRect(cg, rect)

        return cg
    }

    @IBAction func zero(sender:AnyObject) {

    }
    
    @IBAction func one(sender:AnyObject) {

    }
    
    @IBAction func two(sender:AnyObject) {

    }
    
    @IBAction func three(sender:AnyObject) {

    }
    
    @IBAction func four(sender:AnyObject) {

    }
    
    @IBAction func five(sender:AnyObject) {

    }
    
    @IBAction func six(sender:AnyObject) {

    }
    
    @IBAction func seven(sender:AnyObject) {

    }
    
    @IBAction func eight(sender:AnyObject) {

    }
    
    @IBAction func nine(sender:AnyObject) {

    }
    
    @IBAction func point(sender:AnyObject) {

    }
    
    @IBAction func clear(sender:AnyObject) {

    }
    
    @IBAction func pound(sender:AnyObject) {

    }
    
    @IBAction func euro(sender:AnyObject) {

    }
    
    @IBAction func dollar(sender:AnyObject) {

    }
    
    @IBAction func yen(sender:AnyObject) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

