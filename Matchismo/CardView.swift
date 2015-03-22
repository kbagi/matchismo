//
//  CardView.swift
//  Matchismo
//
//  Created by Karol Baginski on 30/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class CardView : UIView {
    var _cardIndex : Int?;
    var cardIndex : Int{
        get{
            if(_cardIndex == nil){
                _cardIndex = Int();
            }
            return _cardIndex!;
        }
        set(newValue){
            _cardIndex = newValue;
        }
    }

}