// Playground - noun: a place where people can play

import Cocoa
import Foundation

var karol = "karol"
var stasiu = "stasiu"
var karol2 = "karol"

karol == karol
karol == karol2
karol == stasiu

var ints:[Int] = [1,2,3,4]

find(ints, 3)!

enum Symbols : Int{
    case Diamond = 0, Squiggle, Oval
}

Symbols.fromRaw(0)


var opt: Int?

enum TrainStatus{
    case OnTime
    case Delayed(Int)
    
    func desc() -> String{
        switch self{
        case OnTime:
            return "cool"
        case Delayed(let minutes):
            return "sdad \(minutes)"
        }
    }
}


var status = TrainStatus.OnTime

status = .Delayed(5)

status.desc()






