//
//  PlayingCardView.swift
//  Matchismo
//
//  Created by Karol Baginski on 26/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation


class SetCardView : CardView{
    
    
    
    //Write your code in drawRect
    override func drawRect(rect: CGRect) {
       
    }
    
        override func awakeFromNib() {
        //self.setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.setup()
    }
    
    required override init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
