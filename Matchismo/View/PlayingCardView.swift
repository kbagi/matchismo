//
//  PlayingCardView.swift
//  Matchismo
//
//  Created by Karol Baginski on 26/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation


class PlayingCardView : CardView{
    var CORNER_FONT_STANDARD_HEIGHT = CGFloat(180.0)
    var CORNER_RADIUS = CGFloat(12.0)
    
    var _suit : String?;
    var suit : String{
        get{
            if(_suit == nil){
                _suit = "♥️"
            }
            return _suit!;
        }
        set(value){
            _suit = value;
        }
    }
    
    var _rank : String?;
    var rank : String{
        get{
            if(_rank == nil){
                _rank = "10"
            }
            return _rank!;
        }
        set(value){
            _rank = value;
        }
    }
    
    var _faceUp : Bool?;
    var faceUp : Bool{
        get{
            if(_faceUp == nil){
                _faceUp = true
            }
            return _faceUp!;
        }
        set(value){
            _faceUp = value;
        }
    }
    
    
    func cornerScaleFactor() -> CGFloat {
        return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT
        
    }
    
    func cornerRadius() -> CGFloat {
        return CORNER_RADIUS * self.cornerScaleFactor()
    }
    
    func cornerOffset() -> CGFloat{
        return self.cornerRadius() / 3.0
    }
    
    //Write your code in drawRect
    override func drawRect(rect: CGRect) {
        var roundedRect = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius())
        roundedRect.addClip()
        
        UIColor.whiteColor().setFill()
        UIRectFill(self.bounds)
        
        UIColor.blackColor().setStroke()
        roundedRect.stroke()
        if(!faceUp){
            var image = UIImage(named: "cardback");
            image.drawInRect(rect);
            
        }else{
           
            drawCorners()
        }
    }
    
    func setup(){
        //self.backgroundColor = UIColor.whiteColor();
        self.opaque = false
        self.contentMode = .Redraw
    }
    
    func drawCorners(){
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        
        var cornerFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        cornerFont = cornerFont.fontWithSize(cornerFont.pointSize * cornerScaleFactor())
        
        var cornerText = NSAttributedString(string: "\(rank)\n\(suit)", attributes: [
            NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle])
        
        var textBounds = CGRect()
        textBounds.origin = CGPointMake(self.cornerOffset(), self.cornerOffset())
        textBounds.size = cornerText.size()
        
        cornerText.drawInRect(textBounds)
        
        var context  = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height)
        CGContextRotateCTM(context, CGFloat(M_PI));
        cornerText.drawInRect(textBounds)
    }
    
    override func awakeFromNib() {
        self.setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required override init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
