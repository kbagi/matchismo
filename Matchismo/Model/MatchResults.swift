//
//  MatchResults.swift
//  Matchismo
//
//  Created by Karol Baginski on 17/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation

struct FlipResult{
    var type:ResultType = ResultType.Flip
    var points:Int = 0
    var cards:[Card] = [Card]();
    enum ResultType{
        case SuccessfulMatch
        case UnsuccesfullMatch
        case Flip
        case None
    }
}
