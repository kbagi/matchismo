//
//  SetCard.swift
//  Matchismo
//
//  Created by Karol Baginski on 16/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.

import Foundation
import UIKit

class SetCard : Card{
    //    class var symbols: [Symbol]{
    //    for s in Shading.{
    //        var s = s;
    //        }
    //    return [Symbol.Oval, Symbol.Square, Symbol.Triangle]
    //    }
    //
    //    class var colours: [Colour] {
    //    return [Colour.Red, Colour.Green, Colour.Yellow];
    //    }
    //
    //    class var numbers:[Int]{
    //    return [1,2,3];
    //    }
    private var _symbol:Symbol?
    var symbol:Symbol?{
        get{
            return _symbol != nil ? _symbol! : nil
        }
        set(symbol){
            self._symbol = symbol;
        }
    }
    private var _shading:Shading?
    var shading:Shading?{
        get{
            return _shading != nil ? _shading! : nil
        }
        set(shading){
            self._shading = shading;
        }
    }
    private var _count:Int?
    var count:Int?{
        get{
            return _count != nil ? _count! : nil
        }
        set(count){
            self._count = count;
        }
    }
    private var _colour:Colour?
    var colour:Colour?{
        get{
            return _colour != nil ? _colour! : nil
        }
        set(colour){
            self._colour = colour;
        }
    }
    
    override func match(otherCards: [Card]) -> Int {
        var score = 0;
        var otherCard1 = otherCards[0] as SetCard;
        var otherCard2 = otherCards[1] as SetCard;
        var countOK = false;
        var shadingOK = false;
        var symbolOK = false;
        var colourOK = false;
        
        if (otherCard1.count != self.count && otherCard2.count != self.count && otherCard1.count != otherCard2.count) ||
            (otherCard1.count == self.count && otherCard2.count == self.count && otherCard1.count == otherCard2.count)
        {
            countOK = true;
        }
        if (otherCard1.shading != self.shading && otherCard2.shading != self.shading && otherCard1.shading != otherCard2.shading) ||
            (otherCard1.shading == self.shading && otherCard2.shading == self.shading && otherCard1.shading == otherCard2.shading)
        {
            shadingOK = true;
        }
        if (otherCard1.symbol != self.symbol && otherCard2.symbol != self.symbol && otherCard1.symbol != otherCard2.symbol) ||
            (otherCard1.symbol == self.symbol && otherCard2.symbol == self.symbol && otherCard1.symbol == otherCard2.symbol)
        {
            symbolOK = true;
        }
        if (otherCard1.colour != self.colour && otherCard2.colour != self.colour && otherCard1.colour != otherCard2.colour) ||
            (otherCard1.colour == self.colour && otherCard2.colour == self.colour && otherCard1.colour == otherCard2.colour)
        {
            colourOK = true;
        }
        
        if(countOK && symbolOK && shadingOK && colourOK){
            score = 5;
        }
        
        return score;
        
    }
    
    enum Symbol : Int{
        case Diamond = 0, Squiggle, Oval
    }
    
    enum Shading : Int{
        case Solid = 0, Striped, Open
    }
    enum Colour : Int{
        case Red = 0, Green, Purple
    }
    
}
