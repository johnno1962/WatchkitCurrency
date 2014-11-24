//
//  InterfaceController.swift
//  Currency WatchKit Extension
//
//  Created by John Holdsworth on 22/11/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var imageView: WKInterfaceImage!

    @IBOutlet weak var pound: WKInterfaceButton!
    @IBOutlet weak var euro: WKInterfaceButton!
    @IBOutlet weak var dollar: WKInterfaceButton!
    @IBOutlet weak var yen: WKInterfaceButton!

    var lastCurrency: String!
    var converted = true
    var displayed = ""

    var rect: CGRect!
    var cg: CGContext!

    var exchangeRates = [
        "pound": 0.6387,
        "euro": 0.8071,
        "dollar": 1.0,
        "yen": 117.78
    ]

    var symbols = [
        "pound": "£",
        "euro": "€",
        "dollar": "$",
        "yen": "¥"
    ]

    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        // Configure interface objects here.
        NSLog("%@ init", self)
        rect = CGRectMake(0.0, 0.0, 245.0, 50.0)
        let bitsPerComponent = 8, bytesPerRow = bitsPerComponent/8*4 * Int(rect.size.width)
        cg = CGBitmapContextCreate(calloc( UInt(bytesPerRow * Int(rect.size.height)), UInt(1) ),
            UInt(rect.size.width), UInt(rect.size.height),
            UInt(bitsPerComponent), UInt(bytesPerRow), CGColorSpaceCreateDeviceRGB(),
            CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue))

        fetchRate( "pound", iso: "GBP" )
        fetchRate( "euro", iso: "EUR" )
        fetchRate( "yen", iso: "JPY" )
        swichToCurrency( "pound" )
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

    var session = NSURLSession.sharedSession()

    func fetchRate( currency: String, iso: String ) {
        let url = "http://download.finance.yahoo.com/d/quotes.csv?s=USD\(iso)=X&f=sl1d1t1ba&e=.csv"
        let request = NSURLRequest( URL:NSURL(string:url)! )

        session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData!, resp: NSURLResponse!, error: NSError!) in
            if data != nil {
                if let csv = NSString( data: data, encoding: NSUTF8StringEncoding ) {
                    let columns = csv.componentsSeparatedByString(",")
                    self.exchangeRates[currency] = columns[1].doubleValue
                }
            }
        }).resume()
    }

    let attribs = [
        NSFontAttributeName: UIFont(name:"Helvetica", size:50.0)!,
        NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    var black: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
    var white: [CGFloat] = [1.0, 1.0, 1.0, 1.0]
    var grey: [CGFloat] = [0.3, 0.7, 0.3, 1.0]

    func setDisplayed( text: NSString ) {
        displayed = text

        CGContextClearRect(cg, rect)
        CGContextSetFillColor(cg, grey)
        CGContextFillRect(cg, rect)

//        CGContextSetLineWidth(cg, 3.0)
//        CGContextSetStrokeColor(cg, white)
//        CGContextStrokeRect(cg, rect)

        let fontStr = NSAttributedString(string:symbols[lastCurrency]!+text, attributes:attribs)
        let displayLine = CTLineCreateWithAttributedString( fontStr )

        CGContextSetTextPosition( cg, 3.0, 6.0 )
        CTLineDraw( displayLine, cg )

        let image = CGBitmapContextCreateImage(cg)
        let uiImage = UIImage(CGImage:image)
        let dev = WKInterfaceDevice.currentDevice()
        dev.addCachedImage(uiImage!, name:"display")
        self.imageView.setImageNamed("display")
    }

    func swichToCurrency( currencyName: String ) {
        var value = (displayed as NSString).doubleValue
        if lastCurrency != nil {
            valueForKey(lastCurrency)!.setBackgroundImageNamed(lastCurrency)
            value /= exchangeRates[lastCurrency]!
        }
        converted = true
        lastCurrency = currencyName
        value *= exchangeRates[currencyName]!
        setDisplayed(String(format:"%.2f", value))
        valueForKey(currencyName)!.setBackgroundImageNamed(currencyName+"_")
    }

    @IBAction func pound(sender:AnyObject) {
        swichToCurrency("pound")
    }

    @IBAction func euro(sender:AnyObject) {
        swichToCurrency("euro")
    }

    @IBAction func dollar(sender:AnyObject) {
        swichToCurrency("dollar")
    }

    @IBAction func yen(sender:AnyObject) {
        swichToCurrency("yen")
    }

    func addChar( char: String, group: String ) {
        if converted {
            converted = false
            displayed = ""
        }
        displayed += char
        setDisplayed(displayed)
    }

    @IBAction func zero(sender:AnyObject) {
        addChar( "0", group: "zero" )
    }

    @IBAction func one(sender:AnyObject) {
        addChar( "1", group: "one" )
    }

    @IBAction func two(sender:AnyObject) {
        addChar( "2", group: "two" )
    }

    @IBAction func three(sender:AnyObject) {
        addChar( "3", group: "three" )
    }

    @IBAction func four(sender:AnyObject) {
        addChar( "4", group: "four" )
    }

    @IBAction func five(sender:AnyObject) {
        addChar( "5", group: "five" )
    }

    @IBAction func six(sender:AnyObject) {
        addChar( "6", group: "six" )
    }

    @IBAction func seven(sender:AnyObject) {
        addChar( "7", group: "seven" )
    }

    @IBAction func eight(sender:AnyObject) {
        addChar( "8", group: "eight" )
    }

    @IBAction func nine(sender:AnyObject) {
        addChar( "9", group: "nine" )
    }

    @IBAction func point(sender:AnyObject) {
        addChar( ".", group: "point" )
    }

    @IBAction func clear(sender:AnyObject) {
        setDisplayed("")
    }

}
