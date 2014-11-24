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

        let views = subviews.sorted {
            return vertical ? $0.frame.origin.y < $1.frame.origin.y : $0.frame.origin.x < $1.frame.origin.x
            }.map { $0 as UIView }

        var place = vertical ? frame.origin.y : frame.origin.x

        for var v=0 ; v<views.count ; v++ {

            let space = (vertical ? views[v].frame.origin.y : views[v].frame.origin.x)-place

            if space != 0 {
                let flow = vertical ? "height" : "width"
                let zero = !vertical ? "height" : "width"
                let basis = vertical ? frame.size.height : frame.size.width
                println( indent+"<group alignment=\"left\" \(flow)=\"\(space/basis)\" \(zero)=\"0.0\" hasDetent=\"YES\" id=\"GEN-\(id++)-GEN\"><items/></group>" )
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
                    println( indent+"<imageView alignment=\"left\" width=\"\(size.width/frame.size.width)\" height=\"\(size.height/frame.size.height)\" id=\"GEN-\(id++)-GEN\"/>" )
                }

                else if let button = newGroup[0] as? UIButton {
                    if let actions = button.actionsForTarget(target, forControlEvent: .TouchUpInside) {
                        if actions.count != 0 {
                            let action = actions[0] as NSString
                            let buttonImage = action.substringToIndex(action.length-1)
                            println( indent+"<button alignment=\"left\" width=\"\(size.width/frame.size.width)\" height=\"\(size.height/frame.size.height)\" backgroundImage=\"\(buttonImage)\" id=\"GEN-\(id++)-GEN\">" )
                            println( indent+"  <connections><action selector=\"\(action)\" destination=\"__TARGET__\" id=\"GEN-\(id++)-GEN\"/></connections>" )
                            println( indent+"</button>" )
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
                    newFrame.size.width = frame.size.width
                }
                else {
                    newFrame.origin.y = frame.origin.y
                    newFrame.size.height = frame.size.height
                }
                let layout = !vertical ? "vertical" : "horizontal"
                println( indent+"<group alignment=\"left\" layout=\"\(layout)\" width=\"\(newFrame.size.width/frame.size.width)\" height=\"\(newFrame.size.height/frame.size.height)\" spacing=\"0.0\" hasDetent=\"YES\" id=\"GEN-\(id++)-GEN\">" )
                println( indent+"  <items>" )
                group( target, frame:newFrame, subviews:newGroup, id:&id,
                    cg: cg, vertical: !vertical, indent: indent+"    " )
                println( indent+"  </items>" )
                println( indent+"</group>" )
            }

            place = vertical ? CGRectGetMaxY( newFrame ) : CGRectGetMaxX( newFrame )
        }

    }

}