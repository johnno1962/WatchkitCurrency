//
//  Group.swift
//  Currency
//
//  Created by John Holdsworth on 21/11/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

import UIKit

class Group {

    class func group( target: UIViewController, frame: CGRect, subviews: [AnyObject],
        inout id: Int, cg: CGContext! = nil, vertical: Bool = true, indent: String = "" ) {

        let layout = vertical ? "vertical" : "horizontal"

        println( indent+"<group alignment=\"left\" layout=\"\(layout)\" hasDetent=\"YES\" id=\"GEN-\(id++)-GEN\">" )
        println( indent+"  <items>" )

        let views = subviews.sorted {
            return vertical ? $0.frame.origin.y < $1.frame.origin.y : $0.frame.origin.x < $1.frame.origin.x
            }.map { $0 as UIView }

        var place = vertical ? frame.origin.y : frame.origin.x

        for var v=0 ; v<views.count ; v++ {

            let space = (vertical ? views[v].frame.origin.y : views[v].frame.origin.x)-place

            if space != 0 {
                let flow = vertical ? "height" : "width"
                let zero = !vertical ? "height" : "width"
                println( indent+"    <group \(flow)=\"\(space/2.0-2.0)\" \(zero)=\"0.0\" alignment=\"left\" hasDetent=\"YES\" id=\"GEN-\(id++)-GEN\"><items/></group>" )
                place += space
            }

            var newGroup = [views[v]]
            var newFrame = views[v].frame

            // consolidate views that overlap vertically/horizontally
            while v+1<views.count &&
                    (vertical ? views[v+1].frame.origin.y : views[v+1].frame.origin.x)
                        <=
                    (vertical ? CGRectGetMaxY( newFrame ) : CGRectGetMaxX( newFrame )) {
                newFrame = CGRectUnion(newFrame, views[++v].frame)
                newGroup.append( views[v] )
            }

            if cg != nil {
                var black: [CGFloat] = [0.3, 0.3, 0.3, 1.0]
                CGContextSetLineWidth(cg, 2.0)
                CGContextSetStrokeColor(cg, black)
                CGContextStrokeRect(cg, newFrame)
            }
            
            // are we down to an individual view
            if newGroup.count == 1 && (vertical ? // and is it hard up against the frame boundary
                    newFrame.origin.x == frame.origin.x : newFrame.origin.y == frame.origin.y) {
                let size = newGroup[0].frame.size;

                if let image =  newGroup[0] as? UIImageView {
                    println( indent+"    <imageView alignment=\"left\" width=\"\(size.width/2.0)\" height=\"\(size.height/2.0)\" id=\"GEN-\(id++)-GEN\"/>" )
                }

                else if let button = newGroup[0] as? UIButton {
                    if let actions = button.actionsForTarget(target, forControlEvent: .TouchUpInside) {
                        if actions.count != 0 {
                            let action = actions[0] as NSString
                            let buttonImage = action.substringToIndex(action.length-1)
                            println( indent+"    <group alignment=\"left\" width=\"\(size.width/2.0)\" height=\"\(size.height/2.0)\" backgroundImage=\"\(buttonImage)\" id=\"GEN-\(id++)-GEN\">")
                            println( indent+"      <items>" )
                            println( indent+"        <button alignment=\"left\" title=\"\(button.currentTitle!)\" width=\"\(size.width/2.0)\" height=\"\(size.height/2.0)\" alpha=\"0.05\" id=\"GEN-\(id++)-GEN\">" )
                            //println( indent+"      <connections><action selector=\"\(action)\" destination=\"CONTROLLER\" id=\"GEN-\(id++)-GEN\"/></connections>" )
                            println( indent+"        </button>" )
                            println( indent+"      </items>" )
                            println( indent+"    </group>" )
                        }
                    }
                }

                else {
                    println( "Unsupported element: \(newGroup[0])" )
                }
            }
            else {
                if vertical {
                    newFrame.origin.x = frame.origin.x
                }
                else {
                    newFrame.origin.y = frame.origin.y
                }
                group( target, frame:newFrame, subviews:newGroup, id:&id,
                    cg: cg, vertical: !vertical, indent: indent+"    " )
            }

            place = vertical ? CGRectGetMaxY( newFrame ) : CGRectGetMaxX( newFrame )
        }

        println( indent+"  </items>" )
        println( indent+"</group>" )
    }

}