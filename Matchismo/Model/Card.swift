//
//  Card.swift
//  StanfordStart
//
//  Created by Karol Baginski on 04/06/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

class Card{
    private var _contents:String?;
    
    internal init(){
        
    }
    var contents:String{
        get {
            return _contents!
        }
    }
    
    private var _chosen:Bool?;
    var chosen:Bool{
        get {
            if(_chosen == nil){
                return false;
            }
            return _chosen!
        }
        set(chosen){
            _chosen = chosen;
        }
    }
    
    private var _matched:Bool?;
    var matched:Bool{
        get {
            if(_matched == nil){
                return false;
            }
            return _matched!
        }
        set(matched){
            _matched = matched;}
    }
    
    func match(otherCards:[Card]) -> Int{
        var score:Int = 0;
        
        for card in otherCards{
            if(card.contents == self.contents)
            {
                score = 1;
            }
        }
        return score;
    }
}
